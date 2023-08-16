import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_controller.dart';

class UserController extends GetxController {
  final Rx<DateTimeRange> selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  final TextEditingController selectedDatesController = TextEditingController();
  final TextEditingController roomBookingController = TextEditingController();
  RxInt? theNumberOfRooms = 0.obs;
  RxInt? theNumberOfAdult = 0.obs;
  RxInt? theNumberOfChildren = 0.obs;

  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> handleSignOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    Get.off(LoginPage());
  }

  Future<void> updateRoomCapacity({
    required int numberOfRooms,
    required int numberOfAdults,
    required int numberOfChildren,
  }) async {
    theNumberOfRooms!.value = numberOfRooms;
    theNumberOfAdult!.value = numberOfAdults;
    theNumberOfChildren!.value = numberOfChildren;
  }

  Future<List<RoomModel>> searchRoomCapacity({
    required int numberOfRooms,
    required int numberOfAdults,
    required int numberOfChildren,
  }) async {
    List<RoomModel> roomList = [];
    try {
      int totalCapacity = numberOfAdults + numberOfChildren;

      await updateRoomCapacity(
        numberOfRooms: numberOfRooms,
        numberOfAdults: numberOfAdults,
        numberOfChildren: numberOfChildren,
      );

      // Query Firestore collection to filter rooms by capacity and quantity
      QuerySnapshot capacityQuery = await FirebaseFirestore.instance
          .collection('rooms') // Change to your collection name
          .where('capacity', isGreaterThanOrEqualTo: totalCapacity)
          .where('statusRoom.description', isEqualTo: 'Available')
          .get();

      // Use the results of capacity query to filter by quantity
      roomList = capacityQuery.docs
          .where((doc) => doc['quantity'] >= numberOfRooms)
          .map((doc) => RoomModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return roomList;
    } catch (e) {
      print("Error searching rooms: $e");
      return [];
      // rethrow;
    }
  }

  Future<List<RoomModel>> filterByName(String roomName) async {
    List<RoomModel> roomList = [];

    try {
      List<RoomModel> capacityFilteredRooms = await searchRoomCapacity(
        numberOfRooms: theNumberOfRooms!.value,
        numberOfAdults: theNumberOfAdult!.value,
        numberOfChildren: theNumberOfChildren!.value,
      );

      roomList = capacityFilteredRooms
          .where((room) =>
          room.typeRoom.nameTypeRoom!
              .toLowerCase()
              .contains(roomName.toLowerCase()))
          .toList();

      return roomList;
    } catch (e) {
      print("Error filtering rooms by name: $e");
      return [];
      // rethrow;
    }
  }

  Future<List<RoomModel>> fetchRoomList() async {
    QuerySnapshot roomSnapshot =
        await FirebaseFirestore.instance.collection('rooms').get();

    List<RoomModel> rooms = roomSnapshot.docs.map((doc) {
      RoomModel room = RoomModel.fromJson(doc.data() as Map<String, dynamic>);
      return room;
    }).toList();

    return rooms;
  }


  double getRating(RoomModel roomModel) {
    double rating = 5;
    if (roomModel.review!.isNotEmpty) {
      double rateTotal = 0;
      roomModel.review?.forEach((element) {
        rateTotal += element!.rate;
      });
      rating = rateTotal / roomModel.review!.length;
    }
    return rating;
  }

  @override
  void onInit() async {
    super.onInit();
    fetchRoomList();
  }
}

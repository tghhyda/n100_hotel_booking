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

  List<RoomModel>? listRoomCapacity;

  Future<void> handleSignOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    Get.off(LoginPage());
  }

  Future<List<RoomModel>> searchRoomCapacity({
    int numberOfRooms = 0,
    int numberOfAdults = 0,
    int numberOfChildren = 0,
    StatusRoomModel? roomStatus,
  }) async {
    try {
      Query roomsQuery = FirebaseFirestore.instance.collection('rooms');

      if (numberOfRooms > 0) {
        roomsQuery = roomsQuery.where('quantity', isEqualTo: numberOfRooms);
      }

      if (numberOfAdults > 0) {
        roomsQuery = roomsQuery.where('numberOfAdult',
            isGreaterThanOrEqualTo: numberOfAdults);
      }

      if (numberOfChildren > 0) {
        roomsQuery = roomsQuery.where('numberOfChildren',
            isGreaterThanOrEqualTo: numberOfChildren);
      }

      if (roomStatus != null) {
        roomsQuery =
            roomsQuery.where('statusRoom.description', isEqualTo: 'Available');
      }

      QuerySnapshot roomSnapshot = await roomsQuery.get();

      List<RoomModel> rooms = roomSnapshot.docs.map((doc) {
        RoomModel room = RoomModel.fromJson(doc.data() as Map<String, dynamic>);
        return room;
      }).toList();

      return rooms;
    } catch (e) {
      print("Error searching rooms: $e");
      return [];
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
    listRoomCapacity = await searchRoomCapacity();
    fetchRoomList();
  }
}

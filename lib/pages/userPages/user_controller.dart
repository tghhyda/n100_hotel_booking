import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
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
  UserModel? currentUser;
  RxInt? rating = 0.obs;
  String? roomId;
  RxBool isInitialized = false.obs;

  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  Future<void> updateRoomQuantity(String roomId, int updatedQuantity) async {
    try {
      await FirebaseFirestore.instance
          .collection('rooms') // Thay thế 'rooms' bằng tên của collection phòng
          .doc(roomId)
          .update({'quantity': updatedQuantity});
      print('Room quantity updated successfully');
    } catch (error) {
      print('Error updating room quantity: $error');
    }
  }

  Future<void> addBookingToFirestore(BookingModel booking) async {
    try {
      await FirebaseFirestore.instance
          .collection(
              'bookings') // Thay thế 'bookings' bằng tên của collection bạn muốn lưu dữ liệu
          .add(booking
              .toJson()); // Chuyển BookingModel thành dữ liệu JSON và thêm vào Firestore

      // Trừ theNumberOfRoom của booking từ quantity của phòng
      if (booking.room != null) {
        RoomModel room = await getRoomById(booking.room!);
        int updatedQuantity = room.quantity - booking.numberOfRooms!;

        if (updatedQuantity >= 0) {
          await updateRoomQuantity(room.idRoom, updatedQuantity);
        } else {
          print('Insufficient quantity of rooms');
        }
      }

      print('Booking added successfully');
    } catch (error) {
      print('Error adding booking: $error');
    }
  }

  String generateRandomId() {
    var random = Random();
    var timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var randomData = List<int>.generate(8, (_) => random.nextInt(256));

    var id = '$timeInMillis${randomData.join('')}';
    return id;
  }

  Future<List<ReviewModel>> getListReviewsForRoom(String roomId) async {
    final CollectionReference reviewsCollection =
        FirebaseFirestore.instance.collection('reviews');

    final QuerySnapshot querySnapshot =
        await reviewsCollection.where('room', isEqualTo: roomId).get();

    final List<ReviewModel> reviews = querySnapshot.docs
        .map((doc) => ReviewModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return reviews;
  }

  Future<void> postReviewAndUpdateRoomModel(
      ReviewModel review, RoomModel room) async {
    try {
      final CollectionReference reviewsCollection =
          FirebaseFirestore.instance.collection('reviews');
      final DocumentReference roomRef =
          FirebaseFirestore.instance.collection('rooms').doc(room.idRoom);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Add the new review to the 'reviews' collection
        await reviewsCollection.add(review.toJson());

        // Get the current reviews list from the RoomModel
        final currentReviews = room.review ?? [];

        // Append the new review to the existing list of reviews
        currentReviews.add(review);

        // Update the 'review' field in the RoomModel with the updated reviews list
        transaction.update(roomRef, {
          'review': currentReviews.map((r) => r?.toJson()).toList(),
        });
      });
      print('Review posted and RoomModel updated successfully');
    } catch (e) {
      AppDefaultDialogWidget()
          .setIsHaveCloseIcon(true)
          .setContent("Post review fail")
          .setAppDialogType(AppDialogType.error)
          .buildDialog(Get.context!)
          .show();

      print('Failed to post review and update RoomModel: $e');
      rethrow;
    }
  }

  Future<UserModel> getCurrentUserInfoByEmail(String email) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception('User not found');
    }
  }

  Future<RoomModel> getRoomById(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('rooms').doc(id).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      RoomModel roomModel = RoomModel.fromJson(data);
      return roomModel;
    } else {
      throw Exception('Room not found');
    }
  }

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
          .where((room) => room.typeRoom.nameTypeRoom!
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

  Future<void> getCurrentUserAndInitialize() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await getCurrentUserInfoByEmail(user.email!);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getCurrentUserAndInitialize();
    await fetchRoomList();
    isInitialized.value = true;
  }

  @override
  void onClose() {
    currentUser = null;
    super.onClose();
  }
}

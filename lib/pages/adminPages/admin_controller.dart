import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/admin_room_view_detail.dart';

class AdminController extends GetxController {
  List<TypeRoomModel>? typeRoomList;
  List<StatusRoomModel>? statusList;

  Future<void> deleteRoomAndCheckBooking(String roomId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final roomRef = firestore.collection('rooms').doc(roomId);


      final bookingSnapshot = await firestore
          .collection('bookings')
          .where('room', isEqualTo: roomId)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        // Room is booked, handle the situation here
        AppDefaultDialogWidget()
            .setAppDialogType(AppDialogType.error)
            .setContent("This room is booked, cannot delete")
            .setIsHaveCloseIcon(true)
            .buildDialog(Get.context!)
            .show();
        print('Cannot delete: Room is booked');
        return;
      }

      // Room is not booked, delete the room
      await roomRef.delete();
      await Get.off(() => AdminRoomDetailPage());
      AppSnackBarWidget()
          .setShowOnTop(SnackPosition.TOP)
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .setContent(const Text("Delete room success"))
          .showSnackBar(Get.context!);
      print('Room deleted successfully');
    } catch (e) {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.error)
          .setContent("Something went wrong")
          .setIsHaveCloseIcon(true)
          .buildDialog(Get.context!)
          .show();
      rethrow;
    }
  }

  Future<int> countBookingsByRoom(String room) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('room', isEqualTo: room)
        .get();

    return querySnapshot.size;
  }

  Future<int> countBookingsByUser(String user) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('user', isEqualTo: user)
        .get();

    return querySnapshot.size;
  }

  Future<List<RoomModel>> fetchRoomList() async {
    try {
      QuerySnapshot roomSnapshot =
          await FirebaseFirestore.instance.collection('rooms').get();

      List<RoomModel> rooms = roomSnapshot.docs.map((doc) {
        RoomModel room = RoomModel.fromJson(doc.data() as Map<String, dynamic>);
        return room;
      }).toList();
      return rooms;
    } catch (e) {
      print("Error fetching room list: $e");
      return [];
    }
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

  Future<List<StatusRoomModel>> fetchStatusList() async {
    try {
      QuerySnapshot statusSnapshot =
          await FirebaseFirestore.instance.collection('statusRooms').get();
      List<StatusRoomModel> statusList = statusSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return StatusRoomModel.fromJson(data);
      }).toList();

      return statusList;
    } catch (e) {
      print("Error fetching status list: $e");
      return [];
    }
  }

  Future<List<ConvenientModel>> fetchConvenientList() async {
    try {
      QuerySnapshot convenientSnapshot =
          await FirebaseFirestore.instance.collection('convenients').get();
      List<ConvenientModel> convenientList = convenientSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ConvenientModel.fromJson(data);
      }).toList();

      return convenientList;
    } catch (e) {
      print("Error fetching convenient list: $e");
      return [];
    }
  }

  Future<List<TypeRoomModel>> fetchTypeRoomList() async {
    try {
      QuerySnapshot typeRoomSnapshot =
          await FirebaseFirestore.instance.collection('typeRooms').get();
      List<TypeRoomModel> typeRoomList = typeRoomSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TypeRoomModel.fromJson(data);
      }).toList();

      return typeRoomList;
    } catch (e) {
      print("Error fetching convenient list: $e");
      return [];
    }
  }

  Future<void> postRoomDataToFirebase(RoomModel roomModel) async {
    try {
      // Serialize RoomModel to a JSON map
      Map<String, dynamic> roomJson = roomModel.toJson();

      // Chuyển đổi các đối tượng phức tạp thành các Map
      Map<String, dynamic> typeRoomJson = roomJson['typeRoom'].toJson();
      roomJson['typeRoom'] = typeRoomJson;

      Map<String, dynamic> statusRoomJson = roomJson['statusRoom'].toJson();
      roomJson['statusRoom'] = statusRoomJson;

      List<Map<String, dynamic>> convenientsJson = [];
      for (ConvenientModel? convenient in roomModel.convenient ?? []) {
        convenientsJson.add(convenient!.toJson());
      }
      roomJson['convenient'] = convenientsJson;

      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomModel.idRoom)
          .set(roomJson);

      print('Room data posted to Firebase successfully');
    } catch (error) {
      print('Error posting room data to Firebase: $error');
      rethrow;
    }
  }

  @override
  void onInit() async {
    fetchRoomList();
    fetchConvenientList();
    fetchStatusList();
    fetchTypeRoomList();
    typeRoomList = await fetchTypeRoomList();
    statusList = await fetchStatusList();
  }
}

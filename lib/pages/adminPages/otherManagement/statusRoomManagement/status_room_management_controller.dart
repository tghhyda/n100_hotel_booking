import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class StatusRoomManagementController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<StatusRoomModel> statusRoomList = <StatusRoomModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Gọi hàm để lấy danh sách StatusRoomModel khi trang được tạo
    fetchStatusRoomList();
  }

  String generateRandomId() {
    var random = Random();
    var timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var randomData = List<int>.generate(8, (_) => random.nextInt(256));

    var id = '$timeInMillis${randomData.join('')}';
    return id;
  }

  Future<void> fetchStatusRoomList() async {
    try {
      final QuerySnapshot statusRoomSnapshot =
          await _firestore.collection('statusRooms').get();
      final List<StatusRoomModel> list = statusRoomSnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return StatusRoomModel.fromJson(data);
      }).toList();

      // Cập nhật danh sách StatusRoomModel vào Observable
      statusRoomList.assignAll(list);
    } catch (e) {
      print("Error fetching status room list: $e");
    }
  }

  Future<void> addStatusRoomToFirebase(StatusRoomModel statusRoom) async {
    final CollectionReference statusRoomCollection =
        FirebaseFirestore.instance.collection('statusRooms');

    try {
      // Sử dụng hàm `toJson` để chuyển đổi đối tượng StatusRoomModel thành Map
      final Map<String, dynamic> statusRoomData = statusRoom.toJson();

      // Thêm dữ liệu Map vào Firestore
      await statusRoomCollection.add(statusRoomData);

      AppSnackBarWidget()
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .setContent(const Text("Add Status Room Success"))
          .showSnackBar(Get.context!);

      await fetchStatusRoomList();
    } catch (e) {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.error)
          .setIsHaveCloseIcon(true)
          .setContent("Something went wrong")
          .buildDialog(Get.context!)
          .show();
      rethrow;
    }
  }

  Future<void> deleteStatusRoom(String statusRoomId) async {
    final CollectionReference statusRoomCollection =
        FirebaseFirestore.instance.collection('statusRooms');

    try {
      // Truy vấn để tìm loại phòng với idStatus tương ứng
      final QuerySnapshot querySnapshot = await statusRoomCollection
          .where('idStatus', isEqualTo: statusRoomId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.delete();

        AppSnackBarWidget()
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.toastMessage)
            .setContent(const Text("Delete Status Room Success"))
            .showSnackBar(Get.context!);

        await fetchStatusRoomList();
      } else {
        // Không tìm thấy loại phòng với idStatus cụ thể
        AppDefaultDialogWidget()
            .setAppDialogType(AppDialogType.error)
            .setIsHaveCloseIcon(true)
            .setContent("Status Room with idStatus '$statusRoomId' not found")
            .buildDialog(Get.context!)
            .show();
      }
    } catch (e) {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.error)
          .setIsHaveCloseIcon(true)
          .setContent("Something went wrong")
          .buildDialog(Get.context!)
          .show();
    }
  }
}

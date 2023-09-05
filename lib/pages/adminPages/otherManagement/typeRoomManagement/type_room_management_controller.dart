import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class TypeRoomManagementController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<TypeRoomModel> typeRoomList = <TypeRoomModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Gọi hàm để lấy danh sách TypeRoomModel khi trang được tạo
    fetchTypeRoomList();
  }

  String generateRandomId() {
    var random = Random();
    var timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var randomData = List<int>.generate(8, (_) => random.nextInt(256));

    var id = '$timeInMillis${randomData.join('')}';
    return id;
  }

  Future<void> fetchTypeRoomList() async {
    try {
      final QuerySnapshot typeRoomSnapshot =
          await _firestore.collection('typeRooms').get();
      final List<TypeRoomModel> list = typeRoomSnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TypeRoomModel.fromJson(data);
      }).toList();

      // Cập nhật danh sách TypeRoomModel vào Observable
      typeRoomList.assignAll(list);
    } catch (e) {
      print("Error fetching type room list: $e");
    }
  }

  Future<void> addTypeRoomToFirebase(TypeRoomModel typeRoom) async {
    final CollectionReference typeRoomCollection =
        FirebaseFirestore.instance.collection('typeRooms');

    try {
      // Sử dụng hàm `toJson` để chuyển đổi đối tượng TypeRoomModel thành Map
      final Map<String, dynamic> typeRoomData = typeRoom.toJson();

      // Thêm dữ liệu Map vào Firestore
      await typeRoomCollection.add(typeRoomData);

      AppSnackBarWidget()
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .setContent(const Text("Add Type Room Success"))
          .showSnackBar(Get.context!);

      await fetchTypeRoomList();
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

  Future<void> deleteTypeRoom(String typeRoomId) async {
    final CollectionReference typeRoomCollection =
        FirebaseFirestore.instance.collection('typeRooms');

    try {
      // Truy vấn để tìm loại phòng với idTypeRoom tương ứng
      final QuerySnapshot querySnapshot = await typeRoomCollection
          .where('idTypeRoom', isEqualTo: typeRoomId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.delete();

        AppSnackBarWidget()
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.toastMessage)
            .setContent(const Text("Delete Type Room Success"))
            .showSnackBar(Get.context!);

        await fetchTypeRoomList();
      } else {
        // Không tìm thấy loại phòng với idTypeRoom cụ thể
        AppDefaultDialogWidget()
            .setAppDialogType(AppDialogType.error)
            .setIsHaveCloseIcon(true)
            .setContent("Type Room with idTypeRoom '$typeRoomId' not found")
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

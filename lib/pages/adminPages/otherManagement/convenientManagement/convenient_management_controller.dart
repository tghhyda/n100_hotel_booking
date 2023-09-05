import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class ConvenientManagementController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<ConvenientModel> convenientList = <ConvenientModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Gọi hàm để lấy danh sách Convenient khi trang được tạo
    fetchConvenientList();
  }

  String generateRandomId() {
    var random = Random();
    var timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var randomData = List<int>.generate(8, (_) => random.nextInt(256));

    var id = '$timeInMillis${randomData.join('')}';
    return id;
  }

  Future<void> fetchConvenientList() async {
    try {
      final QuerySnapshot convenientSnapshot =
          await _firestore.collection('convenients').get();
      final List<ConvenientModel> list = convenientSnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ConvenientModel.fromJson(data);
      }).toList();

      // Cập nhật danh sách Convenient vào Observable
      convenientList.assignAll(list);
    } catch (e) {
      print("Error fetching convenient list: $e");
    }
  }

  Future<void> addConvenientToFirebase(ConvenientModel convenient) async {
    final CollectionReference convenientCollection =
        FirebaseFirestore.instance.collection('convenients');

    try {
      // Sử dụng hàm `toJson` để chuyển đổi đối tượng ConvenientModel thành Map
      final Map<String, dynamic> convenientData = convenient.toJson();

      // Thêm dữ liệu Map vào Firestore
      await convenientCollection.add(convenientData);

      AppSnackBarWidget()
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .setContent(const Text("Add Convenient Success"))
          .showSnackBar(Get.context!);

      await fetchConvenientList();
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

  Future<void> deleteConvenientIfNotUsed(String convenientId) async {
    final CollectionReference convenientCollection =
        FirebaseFirestore.instance.collection('convenients');
    final List<String> roomsUsingConvenient =
        await getRoomsUsingConvenient(convenientId);

    if (roomsUsingConvenient.isEmpty) {
      try {
        // Truy vấn để tìm convenient với idConvenient tương ứng
        final QuerySnapshot querySnapshot = await convenientCollection
            .where('idConvenient', isEqualTo: convenientId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          await documentSnapshot.reference.delete();

          AppSnackBarWidget()
              .setAppSnackBarStatus(AppSnackBarStatus.success)
              .setAppSnackBarType(AppSnackBarType.toastMessage)
              .setContent(const Text("Remove Convenient Success"))
              .showSnackBar(Get.context!);
          await fetchConvenientList();
        } else {
          // Không tìm thấy convenient với idConvenient cụ thể
          AppDefaultDialogWidget()
              .setAppDialogType(AppDialogType.error)
              .setIsHaveCloseIcon(true)
              .setContent(
                  "Convenient with idConvenient '$convenientId' not found")
              .buildDialog(Get.context!)
              .show();
        }
      } catch (e) {
        // Xảy ra lỗi khi xóa convenient
        AppDefaultDialogWidget()
            .setAppDialogType(AppDialogType.error)
            .setIsHaveCloseIcon(true)
            .setContent("Something went wrong")
            .buildDialog(Get.context!)
            .show();
      }
    } else {
      // Convenient đã được sử dụng trong các phòng
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.error)
          .setIsHaveCloseIcon(true)
          .setContent(
              "Cannot remove this convenient, because it is already used for another room")
          .buildDialog(Get.context!)
          .show();
    }
  }

  Future<List<String>> getRoomsUsingConvenient(String convenientId) async {
    final CollectionReference roomCollection =
        FirebaseFirestore.instance.collection('rooms');

    final QuerySnapshot roomSnapshot = await roomCollection
        .where('convenients', arrayContains: convenientId)
        .get();

    final List<String> roomsUsingConvenient = [];

    for (final doc in roomSnapshot.docs) {
      roomsUsingConvenient.add(doc.id);
    }

    return roomsUsingConvenient;
  }
}

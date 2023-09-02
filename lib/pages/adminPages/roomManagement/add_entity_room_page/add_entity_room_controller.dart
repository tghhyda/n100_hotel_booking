import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';

import '../../../../components/snackBar/app_snack_bar_base_builder.dart';

class AddEntityRoomController extends GetxController {
  RoomModel roomModel = Get.arguments;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  final CollectionReference roomsCollection =
      FirebaseFirestore.instance.collection('rooms');
  late String idEntity;

  final adminController = Get.put(AdminController());

  @override
  void onInit() {
    idEntity = generateRandomId();
  }

  Future<void> addEntityRoomAndUpdateRoom(
      String roomId, EntityRoomModel entityRoom) async {
    try {
      DocumentReference entityDocRef =
          await roomsCollection.doc(roomId).collection('entityRooms').add({
        'id': entityRoom.id,
        'name': entityRoom.name,
        'currentBooking': entityRoom.currentBooking != null
            ? {
                'booking': entityRoom.currentBooking?.toJson()
                // Add other relevant fields from BookingModel here
              }
            : null,
      });

      // Update the list of entity rooms in the room
      await roomsCollection.doc(roomId).update({
        'entityRoom': FieldValue.arrayUnion([entityRoom.toJson()]),
      });
      await adminController.fetchRoomList();
      AppSnackBarWidget()
          .setContent(const Text("Add entity room success"))
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar(Get.context!);
    } catch (error) {
      print('Error adding entity room: $error');
      AppDefaultDialogWidget()
          .setContent("Something went wrong")
          .setIsHaveCloseIcon(true)
          .setAppDialogType(AppDialogType.error)
          .buildDialog(Get.context!)
          .show();
      rethrow;
    }
  }

  String generateRandomId() {
    var random = Random();
    var timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var randomData = List<int>.generate(8, (_) => random.nextInt(256));

    var id = '$timeInMillis${randomData.join('')}';
    return id;
  }
}

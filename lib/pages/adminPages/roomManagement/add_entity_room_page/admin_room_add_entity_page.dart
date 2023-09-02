import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/add_entity_room_page/add_entity_room_controller.dart';

class AdminRoomAddEntityPage extends GetView<AddEntityRoomController> {
  AdminRoomAddEntityPage({super.key});

  @override
  final controller = Get.put(AddEntityRoomController());

  @override
  Widget build(BuildContext context) {
    var listEntityRoom = controller.roomModel.entityRoom;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Entity Room"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddingForm(context),
              const SizedBox(
                height: 12,
              ),
              const Divider(),
              AppTextBody1Widget()
                  .setText("List entity room")
                  .setTextStyle(AppTextStyleExt.of.textBody1s)
                  .setColor(AppColors.of.yellowColor[6])
                  .build(context),
              for (var entityRoom in listEntityRoom ?? [])
                _buildEntityRoomRow(entityRoom),
            ]),
      ),
    );
  }

  Widget _buildEntityRoomRow(EntityRoomModel entityRoom) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppTextBody1Widget()
              .setText("Name: ${entityRoom.name}")
              .build(Get.context!),
          AppTextBody1Widget()
              .setText(
                  "Status: ${entityRoom.currentBooking?.user != null ? "Checked-in" : "Available"}")
              .build(Get.context!)
        ],
      ),
    );
  }

  Widget _buildAddingForm(BuildContext context) {
    return Form(
        key: controller.formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppTextFormFieldWidget()
                  .setController(controller.nameController)
                  .setHintText("Input name entity room. Ex: P101")
                  .build(context),
            ),
            IconButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    EntityRoomModel entityRoom = EntityRoomModel(
                        controller.idEntity,
                        controller.nameController.text,
                        null);
                    controller.addEntityRoomAndUpdateRoom(
                        controller.roomModel.idRoom, entityRoom);
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ));
  }
}

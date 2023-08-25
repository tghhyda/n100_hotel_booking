import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/edit_room_page/edit_room_controller.dart';

class EditRoomPage extends GetView<EditRoomController> {
  EditRoomPage({super.key});

  @override
  final controller = Get.put(EditRoomController());

  TextEditingController priceController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set the initial values for the controllers
    priceController.text = controller.roomModel.value!.priceRoom.toString();
    bedsController.text = controller.roomModel.value!.beds.toString();
    capacityController.text = controller.roomModel.value!.capacity.toString();
    quantityController.text = controller.roomModel.value!.quantity.toString();
    areaController.text = controller.roomModel.value!.area.toString();
    descriptionController.text = controller.roomModel.value!.description;

    return Obx(() => Scaffold(
          backgroundColor: AppColorsExt.backgroundColor,
          appBar: AppBar(
            title: Text(
                'Edit Room ${controller.roomModel.value!.typeRoom.nameTypeRoom}'),
            backgroundColor: AppColorsExt.backgroundColor,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // You can add your form fields here for editing the room details
                  // For example:
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: bedsController,
                    decoration: const InputDecoration(labelText: 'Number of Beds'),
                    keyboardType: TextInputType.number,
                  ),
                  // Add other form fields similarly

                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.selectedImages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.selectedImages.length) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: controller.onSelectImages,
                                // Similar to AddRoomPage
                                child: const Text('Edit Images'),
                              ),
                            ),
                          );
                        }

                        // Display existing images (local files)
                        File imageFile = controller.selectedImages[index];

                        if (imageFile.existsSync()) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.of.grayColor[7]!
                                        .withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(imageFile),
                              ),
                            ),
                          );
                        } else {
                          // Display images from URLs
                          String? imageUrl =
                              controller.roomModel.value!.images![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.of.grayColor[7]!
                                        .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 0,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(imageUrl!),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.of.yellowColor[5],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () async {
                      },
                      child: AppTextBody1Widget()
                          .setTextStyle(AppTextStyleExt.of.textBody1s)
                          .setText("Save")
                          .build(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void updateRoomDetails() {
    // You can implement the logic to update the room details here
    // For example, you can use your controller's method to update the room in the database
    // and then show a snackbar or navigate back to the previous page.
  }
}

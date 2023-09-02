import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/formField/app_form_field_widget.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/edit_room_page/edit_room_controller.dart';

class EditRoomPage extends GetView<EditRoomController> {
  EditRoomPage({super.key});

  @override
  final controller = Get.put(EditRoomController());

  Rx<TypeRoomModel?>? editedTypeRoom = Rx<TypeRoomModel?>(null);

  @override
  Widget build(BuildContext context) {
    // Set the initial values for the controllers

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
                  AppFormFieldWidget(
                    labelText: 'Type Room',
                    isRequired: true,
                    child: FutureBuilder<List<TypeRoomModel>>(
                      future: controller.fetchTypeRoomList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No data available.');
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.of.grayColor[1],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              const Icon(Icons.room_service_outlined),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: Obx(
                                    () => DropdownButton2<TypeRoomModel>(
                                      isExpanded: true,
                                      hint: const Text('Select Type Room'),
                                      items: snapshot.data!
                                          .map((TypeRoomModel item) {
                                        return DropdownMenuItem<TypeRoomModel>(
                                          value: item,
                                          child: AppTextBody1Widget()
                                              .setText(item.nameTypeRoom ?? '')
                                              .build(context),
                                        );
                                      }).toList(),
                                      value:
                                          controller.selectedTypeRoom?.value !=
                                                  null
                                              ? snapshot.data!.firstWhere(
                                                  (type) =>
                                                      type.idTypeRoom ==
                                                      controller
                                                          .selectedTypeRoom
                                                          ?.value
                                                          ?.idTypeRoom,
                                                  orElse: () =>
                                                      snapshot.data!.first,
                                                )
                                              : null,
                                      onChanged: (value) {
                                        controller.selectedTypeRoom?.value =
                                            value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppFormFieldWidget(
                    labelText: "Status room",
                    isRequired: true,
                    child: FutureBuilder<List<StatusRoomModel>>(
                      future: controller.fetchStatusList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No data available.');
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.of.grayColor[1],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              const Icon(Icons.meeting_room_outlined),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: Obx(
                                    () => DropdownButton2<StatusRoomModel>(
                                      isExpanded: true,
                                      hint: const Text('Select Status Room'),
                                      items: snapshot.data!
                                          .map((StatusRoomModel item) {
                                        return DropdownMenuItem<
                                            StatusRoomModel>(
                                          value: item,
                                          child: Row(
                                            children: [
                                              AppTextBody1Widget()
                                                  .setText(
                                                      item.description ?? '')
                                                  .build(context),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      value: controller
                                                  .selectedStatusRoom?.value !=
                                              null
                                          ? snapshot.data!.firstWhere(
                                              (status) =>
                                                  status.idStatus ==
                                                  controller.selectedStatusRoom
                                                      ?.value?.idStatus,
                                              orElse: () =>
                                                  snapshot.data!.first,
                                            )
                                          : null,
                                      onChanged: (value) {
                                        controller.selectedStatusRoom?.value =
                                            value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppFormFieldWidget(
                          labelText: "Price(VND) / Night",
                          isRequired: true,
                          child: AppTextFormFieldWidget()
                              .setController(controller.priceController)
                              .setHintText("Price")
                              .setPrefixIcon(
                                  const Icon(Icons.attach_money_sharp))
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .setInputType(TextInputType.number)
                              .setValidator((value) {
                            if (value!.isEmpty) {
                              return "This field cannot null";
                            } else {
                              if (!value.isNumericOnly) {
                                return "This field must be numeric only";
                              }
                            }
                            return null;
                          }).build(context))
                      .build(context),
                  const SizedBox(
                    height: 8,
                  ),
                  AppFormFieldWidget(
                          labelText: "The number of bed / Room",
                          isRequired: true,
                          child: AppTextFormFieldWidget()
                              .setController(controller.bedsController)
                              .setHintText("The number of bed")
                              .setPrefixIcon(const Icon(Icons.bed))
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .setInputType(TextInputType.number)
                              .setValidator((value) {
                            if (value!.isEmpty) {
                              return "This field cannot null";
                            } else {
                              if (!value.isNumericOnly) {
                                return "This field must be numeric only";
                              }
                              if (int.parse(value) < 1) {
                                return "1 room must have at least 1 bed";
                              }
                              if (int.parse(value) > 4) {
                                return "1 room must have a maximum of 4 beds";
                              }
                            }
                            return null;
                          }).build(context))
                      .build(context),
                  const SizedBox(
                    height: 8,
                  ),
                  AppFormFieldWidget(
                          labelText: "Capacity",
                          isRequired: true,
                          child: AppTextFormFieldWidget()
                              .setController(controller.capacityController)
                              .setHintText("The number of people / Room")
                              .setPrefixIcon(const Icon(Icons.people_outline))
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .setInputType(TextInputType.number)
                              .setValidator((value) {
                            if (value!.isEmpty) {
                              return "This field cannot null";
                            } else {
                              if (!value.isNumericOnly) {
                                return "This field must be numeric only";
                              }
                              if (int.parse(value) < 1) {
                                return "Capacity must have at least 1 person";
                              }
                            }
                            return null;
                          }).build(context))
                      .build(context),
                  const SizedBox(
                    height: 8,
                  ),
                  AppFormFieldWidget(
                          labelText: "Quantity",
                          isRequired: true,
                          child: AppTextFormFieldWidget()
                              .setController(controller.quantityController)
                              .setHintText("The number of room")
                              .setPrefixIcon(
                                  const Icon(Icons.meeting_room_sharp))
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .setInputType(TextInputType.number)
                              .setValidator((value) {
                            if (value!.isEmpty) {
                              return "This field cannot null";
                            } else {
                              if (!value.isNumericOnly) {
                                return "This field must be numeric only";
                              }
                              if (int.parse(value!) < 1) {
                                return "At least 1 room";
                              }
                            }
                            return null;
                          }).build(context))
                      .build(context),
                  const SizedBox(
                    height: 8,
                  ),
                  AppFormFieldWidget(
                          labelText: "Area",
                          isRequired: true,
                          child: AppTextFormFieldWidget()
                              .setController(controller.areaController)
                              .setHintText("Area in square meters")
                              .setPrefixIcon(const Icon(Icons.square_foot))
                              .setAutoValidateMode(
                                  AutovalidateMode.onUserInteraction)
                              .setInputType(TextInputType.number)
                              .setValidator((value) {
                            if (value!.isEmpty) {
                              return "This field cannot null";
                            } else {
                              if (!value.isNumericOnly) {
                                return "This field must be numeric only";
                              }
                            }
                            return null;
                          }).build(context))
                      .build(context),
                  const SizedBox(
                    height: 8,
                  ),
                  AppFormFieldWidget(
                          labelText: "Description",
                          isRequired: false,
                          child: AppTextFormFieldWidget()
                              .setController(controller.descriptionController)
                              .setHintText("Description")
                              .setMinLine(3)
                              .setPrefixIcon(const Icon(Icons.description))
                              .build(context))
                      .build(context),
                  const SizedBox(height: 8,),
                  AppFormFieldWidget(
                    labelText: "Convenient",
                    isRequired: false,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.of.grayColor[2],
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: FutureBuilder<List<ConvenientModel>>(
                        future: controller.fetchConvenientList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return Wrap(
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 8.0,
                              children: snapshot.data!.map((convenient) {
                                return Obx(
                                  () => InputChip(
                                    label: Text(convenient.nameConvenient),
                                    selected: controller.selectedConvenients!
                                        .contains(convenient),
                                    selectedColor: AppColors.of.yellowColor[5],
                                    onSelected: (isSelected) {
                                      if (isSelected) {
                                        if (!controller.selectedConvenients
                                            .contains(convenient)) {
                                          controller.selectedConvenients
                                              .add(convenient);
                                        }
                                      } else {
                                        controller.selectedConvenients
                                            .remove(convenient);
                                      }
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return const Text('No data available.');
                          }
                        },
                      ),
                    ),
                  ).build(context),
                  const SizedBox(height: 8,),
                  AppFormFieldWidget(
                    labelText: "Images",
                    isRequired: false,
                    child: SizedBox(
                      height: controller.selectedImages.isNotEmpty ? 200 : 40,
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
                  ).build(context),
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
                        RoomModel updatedRoom = RoomModel(
                          controller.roomModel.value!.idRoom,
                          controller.selectedTypeRoom!.value!,
                          // Assume selectedTypeRoom is not null
                          int.parse(controller.priceController.text),
                          int.parse(controller.capacityController.text),
                          int.parse(controller.areaController.text),
                          int.parse(controller.bedsController.text),
                          int.parse(controller.quantityController.text),
                          controller.selectedStatusRoom!.value!,
                          // You may need to update this
                          controller.selectedConvenients!.toList(),
                          controller.roomModel.value!.review,
                          controller.roomModel.value!.images,
                          controller.roomModel.value!.entityRoom,
                          controller.descriptionController.text,
                        );

                        await controller.updateRoomInDatabase(updatedRoom);
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
}

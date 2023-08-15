import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/components/formField/app_form_field_widget.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';

class AddRoomPage extends GetView<AdminController> {
  AddRoomPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  final controller = Get.put(AdminController());

  Future<List<StatusRoomModel>> fetchStatusList() async {
    List<StatusRoomModel> statusList = await controller.fetchStatusList();
    return statusList;
  }

  Future<List<ConvenientModel>> fetchConvenientList() async {
    List<ConvenientModel> convenientList =
        await controller.fetchConvenientList();
    return convenientList;
  }

  Future<List<TypeRoomModel>> fetchTypeRoomList() async {
    List<TypeRoomModel> typeRoomList = await controller.fetchTypeRoomList();
    return typeRoomList;
  }

  Rx<TypeRoomModel?>? selectedTypeRoom = Rx<TypeRoomModel?>(null);
  RxList<ConvenientModel>? selectedConvenients = <ConvenientModel>[].obs;
  Rx<StatusRoomModel?>? selectedStatusRoom = Rx<StatusRoomModel?>(null);
  RxList<File> selectedImages = <File>[].obs;

  TextEditingController priceController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: const Text('Add Room'),
        backgroundColor: AppColorsExt.backgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                AppFormFieldWidget(
                  labelText: 'Type Room',
                  isRequired: true,
                  child: FutureBuilder<List<TypeRoomModel>>(
                    future: fetchTypeRoomList(), // Future<List<TypeRoomModel>>
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Hoặc một phần giao diện khác để hiển thị khi đang tải
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Container(
                            decoration: BoxDecoration(
                                color: AppColors.of.grayColor[1],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey, // Màu sắc của đường viền
                                  width: 1.0, // Độ dày của đường viền
                                )),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(Icons.room_service_outlined),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: Obx(
                                      () => DropdownButton2<TypeRoomModel>(
                                        isExpanded: true,
                                        hint: const Text('Select Type Room'),
                                        items: snapshot.data!
                                            .map((TypeRoomModel item) {
                                          return DropdownMenuItem<
                                              TypeRoomModel>(
                                            value: item,
                                            child: AppTextBody1Widget()
                                                .setText(
                                                    item.nameTypeRoom ?? '')
                                                .build(context),
                                          );
                                        }).toList(),
                                        value: selectedTypeRoom?.value,
                                        onChanged: (value) {
                                          selectedTypeRoom?.value = value!;
                                          print(
                                              '${selectedTypeRoom?.value?.nameTypeRoom}');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      } else {
                        return const Text('No data available.');
                      }
                    },
                  ),
                ).build(context),
                const SizedBox(
                  height: 8,
                ),
                AppFormFieldWidget(
                  labelText: "Status room",
                  isRequired: true,
                  child: FutureBuilder<List<StatusRoomModel>>(
                    future: fetchStatusList(), // Future<List<TypeRoomModel>>
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Hoặc một phần giao diện khác để hiển thị khi đang tải
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Container(
                            decoration: BoxDecoration(
                                color: AppColors.of.grayColor[1],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey, // Màu sắc của đường viền
                                  width: 1.0, // Độ dày của đường viền
                                )),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
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
                                        value: selectedStatusRoom?.value,
                                        onChanged: (value) {
                                          selectedStatusRoom?.value = value!;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      } else {
                        return const Text('No data available.');
                      }
                    },
                  ),
                ).build(context),
                const SizedBox(
                  height: 8,
                ),
                AppFormFieldWidget(
                        labelText: "Price(VND) / Night",
                        isRequired: true,
                        child: AppTextFormFieldWidget()
                            .setController(priceController)
                            .setHintText("Price")
                            .setPrefixIcon(const Icon(Icons.attach_money_sharp))
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
                            .setController(bedsController)
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
                            if (int.parse(value!) < 1) {
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
                            .setController(capacityController)
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
                            if (int.parse(value!) < 1) {
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
                            .setController(quantityController)
                            .setHintText("The number of room")
                            .setPrefixIcon(const Icon(Icons.meeting_room_sharp))
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
                            .setController(areaController)
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
                            .setController(descriptionController)
                            .setHintText("Description")
                            .setMinLine(3)
                            .setPrefixIcon(const Icon(Icons.description))
                            .build(context))
                    .build(context),
                const SizedBox(
                  height: 8,
                ),
                //
                AppFormFieldWidget(
                  labelText: "Convenient",
                  isRequired: false,
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        color: AppColors.of.grayColor[2],
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)),
                    child: FutureBuilder<List<ConvenientModel>>(
                      future: fetchConvenientList(),
                      // Future<List<TypeRoomModel>>
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Hoặc một phần giao diện khác để hiển thị khi đang tải
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
                                  selected:
                                      selectedConvenients!.contains(convenient),
                                  selectedColor: AppColors.of.yellowColor[5],
                                  onSelected: (isSelected) {
                                    if (isSelected) {
                                      selectedConvenients?.add(convenient);
                                      print('${selectedConvenients?.length}');
                                    } else {
                                      selectedConvenients?.remove(convenient);
                                      print('${selectedConvenients?.length}');
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
                const SizedBox(
                  height: 8,
                ),
                AppFormFieldWidget(
                  labelText: "Images",
                  isRequired: false,
                  child: Obx(
                    () => SizedBox(
                      height: selectedImages.isNotEmpty ? 200 : 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == selectedImages.length) {
                            return Align(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: InkWell(
                                      onTap: _onSelectImages,
                                      child: const Text('Add Images'),
                                    )));
                          }
                          // Nếu index nhỏ hơn số phần tử trong danh sách, hiển thị hình ảnh từ danh sách selectedImages
                          File imageFile = selectedImages[index];
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
                                    child: Image.file(imageFile))),
                          );
                        },
                      ),
                    ),
                  ),
                ).build(context),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.of.yellowColor[5],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              width: 1,
                              color: AppColors.of.grayColor[10] ??
                                  Colors.black), // Thay đổi border radius ở đây
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          try {
                            selectedTypeRoom?.value ??=
                                controller.typeRoomList?.first;
                            selectedStatusRoom?.value ??=
                                controller.statusList?.first;

                            // RoomModel room1 = RoomModel(
                            //     idRoom,
                            //     typeRoom,
                            //     priceRoom,
                            //     capacity,
                            //     area,
                            //     beds,
                            //     quantity,
                            //     statusRoom,
                            //     convenient,
                            //     review,
                            //     images,
                            //     description);

                            RoomModel room = RoomModel(
                                generateRandomId(),
                                selectedTypeRoom!.value!,
                                int.parse(priceController.text),
                                int.parse(capacityController.text),
                                int.parse(areaController.text),
                                int.parse(bedsController.text),
                                int.parse(quantityController.text),
                                selectedStatusRoom!.value ??
                                    controller.statusList!.first,
                                selectedConvenients!,
                                [],
                                [],
                                descriptionController.text);
                            _onUploadImages();
                            controller.postRoomDataToFirebase(room);
                          } catch (e) {
                            rethrow;
                          }
                          AppSnackBarWidget()
                              .setAppSnackBarType(AppSnackBarType.toastMessage)
                              .setAppSnackBarStatus(AppSnackBarStatus.success)
                              .setContent(AppTextBody1Widget()
                                  .setText("Add room success")
                                  .build(context))
                              .showSnackBar(context);
                        } else {
                          AppSnackBarWidget()
                              .setAppSnackBarType(AppSnackBarType.toastMessage)
                              .setAppSnackBarStatus(AppSnackBarStatus.error)
                              .setContent(AppTextBody1Widget()
                                  .setText("Add room fail")
                                  .build(context))
                              .showSnackBar(context);
                        }
                      },
                      child: AppTextBody1Widget()
                          .setText("Add Room")
                          .build(context)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectImages() async {
    List<File> images = await pickMultipleImages();
    selectedImages.value = images;
  }

  String generateRandomId() {
    var random = Random();
    var timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var randomData = List<int>.generate(8, (_) => random.nextInt(256));

    var id = '$timeInMillis${randomData.join('')}';
    return id;
  }

  void _onUploadImages() async {
    String roomId = generateRandomId();
    List<String> imageUrls =
        await uploadImagesToFirebase(selectedImages, roomId);
    FirebaseFirestore.instance.collection('rooms').doc(roomId).set({
      'images': imageUrls,
    }, SetOptions(merge: true));
    // widget.onAddRoomCallback();
  }

  Future<List<File>> pickMultipleImages() async {
    List<XFile>? selectedFiles = await ImagePicker().pickMultiImage();
    if (selectedFiles == null) return [];

    List<File> images = [];
    for (XFile file in selectedFiles) {
      images.add(File(file.path));
    }
    return images;
  }

  Future<List<String>> uploadImagesToFirebase(
      List<File> images, String roomId) async {
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      String imageName = '$roomId-image-$i.jpg'; // Đặt tên duy nhất cho mỗi ảnh
      Reference ref =
          FirebaseStorage.instance.ref().child('room_images').child(imageName);

      await ref.putFile(images[i]);

      String downloadUrl = await ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }
}

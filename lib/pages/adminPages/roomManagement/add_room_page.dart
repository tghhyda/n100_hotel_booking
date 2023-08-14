import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/components/dropdownButton/app_dropdown_button_future_widget.dart';
import 'package:n100_hotel_booking/components/dropdownButton/app_dropdown_button_second_type_widget.dart';
import 'package:n100_hotel_booking/components/textFormField/text_form_field_widget.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';
import 'admin_room_controller.dart';

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
  List<ConvenientModel>? selectedConvenients;
  Rx<StatusRoomModel?>? selectedStatusRoom = Rx<StatusRoomModel?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: const Text('Add Room'),
        backgroundColor: AppColorsExt.backgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                FutureBuilder<List<TypeRoomModel>>(
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
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton2<TypeRoomModel>(
                              isExpanded: true,
                              hint: const Text('Select Type Room'),
                              items: snapshot.data!.map((TypeRoomModel item) {
                                return DropdownMenuItem<TypeRoomModel>(
                                  value: item,
                                  child: Text(item.nameTypeRoom ?? ''),
                                );
                              }).toList(),
                              value: selectedTypeRoom?.value,
                              onChanged: (value) {
                                selectedTypeRoom?.value = value!;
                              },
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Text('No data available.');
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                FutureBuilder<List<StatusRoomModel>>(
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
                            const Icon(Icons.abc)
                            ,
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: Obx(
                                      () => DropdownButton2<StatusRoomModel>(
                                    isExpanded: true,
                                    hint: const Text('Select Status Room'),
                                    items: snapshot.data!.map((StatusRoomModel item) {
                                      return DropdownMenuItem<StatusRoomModel>(
                                        value: item,
                                        child: Row(
                                          children: [
                                            Text(item.description ?? '')
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
                        )
                      );
                    } else {
                      return const Text('No data available.');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _onSelectImages() async {
  //   List<File> images = await pickMultipleImages();
  //   setState(() {
  //     selectedImages = images;
  //   });
  // }
  //
  // void _onUploadImages() async {
  //   String roomId = nameRoomController
  //       .text; // Sử dụng mã phòng hoặc bất kỳ định danh duy nhất nào cho các ảnh
  //   List<String> imageUrls =
  //       await uploadImagesToFirebase(selectedImages, roomId);
  //   FirebaseFirestore.instance.collection('rooms').doc(roomId).set({
  //     'images': imageUrls,
  //   }, SetOptions(merge: true));
  //   // widget.onAddRoomCallback();
  // }

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

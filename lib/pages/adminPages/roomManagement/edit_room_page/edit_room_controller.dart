import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class EditRoomController extends GetxController {
  Rxn<RoomModel> roomModel = Rxn<RoomModel>(null);
  RxList<File> selectedImages = <File>[].obs;

  @override
  void onInit() {
    // Initialize the roomModel reactive state
    roomModel.value = Get.arguments;
    selectedImages.value =
        roomModel.value?.images?.map((imageUrl) => File(imageUrl!)).toList() ??
            <File>[];
    super.onInit();
  }

  void onSelectImages() async {
    List<File> images = await pickMultipleImages();
    // Now, you'll need to upload the new images and update the room's images in the database
    onUploadImages(roomModel.value!.idRoom, images);
    selectedImages.value = images;
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

  void onUploadImages(String roomId, List<File> newImages) async {
    if (roomModel.value?.images != null) {
      // Delete existing images from storage (if needed)
      for (String? imageUrl in roomModel.value!.images!) {
        if (imageUrl != null) {
          await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        }
      }
    }

    // Upload new images
    List<String> imageUrls = await uploadImagesToFirebase(newImages, roomId);

    // Update images array in Firestore
    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .update({'images': imageUrls});

    // Refresh the room model with new image URLs
    roomModel.value?.images = imageUrls;
    update();
  }

  Future<List<String>> uploadImagesToFirebase(
      List<File> images, String roomId) async {
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      String imageName = '$roomId-image-$i.jpg';
      Reference ref =
          FirebaseStorage.instance.ref().child('room_images').child(imageName);

      await ref.putFile(images[i]);

      String downloadUrl = await ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }
}

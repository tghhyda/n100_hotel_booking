import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class EditRoomController extends GetxController {
  Rxn<RoomModel> roomModel = Rxn<RoomModel>(null);
  RxList<File> selectedImages = <File>[].obs;
  Rx<TypeRoomModel?>? selectedTypeRoom = Rx<TypeRoomModel?>(null);
  RxSet<ConvenientModel> selectedConvenients = <ConvenientModel>{}.obs;
  Rx<StatusRoomModel?>? selectedStatusRoom = Rx<StatusRoomModel?>(null);

  TextEditingController priceController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<TypeRoomModel>? typeRoomList;

  @override
  void onInit() async {
    // Initialize the roomModel reactive state
    roomModel.value = Get.arguments;
    priceController.text = roomModel.value!.priceRoom.toString();
    bedsController.text = roomModel.value!.beds.toString();
    capacityController.text = roomModel.value!.capacity.toString();
    quantityController.text = roomModel.value!.quantity.toString();
    areaController.text = roomModel.value!.area.toString();
    descriptionController.text = roomModel.value!.description;
    selectedTypeRoom?.value = roomModel.value!.typeRoom;
    selectedStatusRoom?.value = roomModel.value!.statusRoom;
    selectedConvenients?.value =
        Set<ConvenientModel>.from(roomModel.value?.convenient ?? []);

    selectedImages.value =
        roomModel.value?.images?.map((imageUrl) => File(imageUrl!)).toList() ??
            <File>[];
    super.onInit();
  }

  Future<void> updateRoomInDatabase(RoomModel updatedRoom) async {
    try {
      // Reference to the room document in Firestore
      final roomDoc = FirebaseFirestore.instance
          .collection('rooms')
          .doc(updatedRoom.idRoom);

      // Prepare the data to update
      Map<String, dynamic> updatedData = {
        'typeRoom': updatedRoom.typeRoom.toJson(),
        'statusRoom': updatedRoom.statusRoom.toJson(),
        'priceRoom': updatedRoom.priceRoom,
        'capacity': updatedRoom.capacity,
        'area': updatedRoom.area,
        'beds': updatedRoom.beds,
        'quantity': updatedRoom.quantity,
        'description': updatedRoom.description,
        'convenient': updatedRoom.convenient
            ?.map((convenient) => convenient?.toJson())
            .toList(),
        // Add other fields here as needed
      };

      // Update the room data
      await roomDoc.update(updatedData);

      // Show a success message or handle success as needed
      print('Room updated successfully');
    } catch (e) {
      // Handle the error, show an error message, or log the error
      print('Error updating room: $e');
    }
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

  Future<List<StatusRoomModel>> fetchStatusList() async {
    try {
      QuerySnapshot statusSnapshot =
          await FirebaseFirestore.instance.collection('statusRooms').get();
      List<StatusRoomModel> statusList = statusSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return StatusRoomModel.fromJson(data);
      }).toList();

      return statusList;
    } catch (e) {
      print("Error fetching status list: $e");
      return [];
    }
  }

  Future<List<ConvenientModel>> fetchConvenientList() async {
    try {
      QuerySnapshot convenientSnapshot =
          await FirebaseFirestore.instance.collection('convenients').get();
      List<ConvenientModel> convenientList = convenientSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ConvenientModel.fromJson(data);
      }).toList();

      return convenientList;
    } catch (e) {
      print("Error fetching convenient list: $e");
      return [];
    }
  }

  Future<List<TypeRoomModel>> fetchTypeRoomList() async {
    try {
      QuerySnapshot typeRoomSnapshot =
          await FirebaseFirestore.instance.collection('typeRooms').get();
      List<TypeRoomModel> typeRoomList = typeRoomSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TypeRoomModel.fromJson(data);
      }).toList();

      return typeRoomList;
    } catch (e) {
      print("Error fetching convenient list: $e");
      return [];
    }
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_controller.dart';

class ProfileController extends GetxController {
  late final Rxn<UserModel?> currentUser = Rxn<UserModel?>();
  RxBool isEditMode = false.obs;
  RxBool isInitialized = false.obs;
  RxString avatarUrl = ''.obs;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() async {
    await getCurrentUserAndInitialize();
    avatarUrl.value = currentUser.value?.imageUrl ?? '';
    isInitialized.value = true;
    super.onInit();
  }

  Future<void> getCurrentUserAndInitialize() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser.value = await getCurrentUserInfoByEmail(user.email!);
    }
  }

  Future<UserModel> getCurrentUserInfoByEmail(String email) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> handleSignOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    Get.offAll(LoginPage());
  }

  Future<void> updateAvatar(File newAvatar) async {
    try {
      if (currentUser == null) {
        print('Current user is not available');
        return;
      }

      if (currentUser.value?.imageUrl?.isNotEmpty == true) {
        await FirebaseStorage.instance
            .refFromURL(currentUser.value!.imageUrl!)
            .delete();
      }

      // Upload the new avatar image to Firebase Storage
      String storagePath =
          'avatars/${currentUser.value?.email}/${DateTime.now().millisecondsSinceEpoch}';
      TaskSnapshot storageTask =
          await FirebaseStorage.instance.ref(storagePath).putFile(newAvatar);

      String imageUrl = await storageTask.ref.getDownloadURL();
      currentUser.value?.imageUrl = imageUrl;

      // Update the user's data in Firestore
      await updateUser(currentUser.value!);

      avatarUrl.value = imageUrl;
      print('Avatar updated successfully');
    } catch (e) {
      print('Error updating avatar: $e');
    }
  }

  Future<void> pickImageAndUpload() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, // Chọn hình ảnh từ thư viện ảnh
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        await updateAvatar(imageFile);
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> updateUser(UserModel newUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser
              .value!.email) // Sử dụng email của người dùng hiện tại để làm ID
          .update(newUser.toJson());

      currentUser.value =
          newUser; // Cập nhật thông tin người dùng hiện tại trong controller
      print('User updated successfully');
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}

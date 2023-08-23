import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class ProfileController extends GetxController {
  late final UserModel? currentUser;
  RxBool isEditMode = false.obs;
  RxBool isInitialized = false.obs;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        currentUser = await getCurrentUserInfoByEmail(user.email!);
      }
    } catch (e) {
      print('Error initializing currentUser: $e');
    }
    isInitialized.value = true;
    super.onInit();
  }

  @override
  void onClose() {
    currentUser = null; // Set currentUser to null when the controller is disposed
    super.onClose();
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

  Future<void> updateUser(UserModel newUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!
              .email) // Sử dụng email của người dùng hiện tại để làm ID
          .update(newUser.toJson());

      currentUser =
          newUser; // Cập nhật thông tin người dùng hiện tại trong controller
      print('User updated successfully');
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}

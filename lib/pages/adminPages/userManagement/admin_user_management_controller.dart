import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class AdminUserManagementController extends GetxController {
  final RxList<UserModel> userList = RxList<UserModel>([]);
  final RxList<UserModel> filteredUserList = RxList<UserModel>([]);
  final RxString searchQuery = RxString('');
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<UserModel>> getUsersByRole(String role) async {
    List<UserModel> users = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: role)
          .get();

      querySnapshot.docs.forEach((doc) {
        users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
      });

      return users;
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  void updateFilteredUserList(String query) {
    final List<UserModel> filteredUsers = userList.where((user) {
      final name = user.nameUser!.toLowerCase();
      return name.contains(query);
    }).toList();
    filteredUserList.assignAll(filteredUsers);
  }

  Future<void> deleteUser(UserModel user) async {
    if (user.role == 'User') {
      final List<BookingModel> bookings = await getBookingsByUser(user.email);

      if (bookings.isNotEmpty) {
        AppDefaultDialogWidget()
            .setIsHaveCloseIcon(true)
            .setAppDialogType(AppDialogType.error)
            .setContent("This user used to booking, cannot be delete")
            .buildDialog(Get.context!)
            .show();
        return;
      }
    }

    try {

      await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(user.email)
          .then((providers) async {
        if (providers.isNotEmpty) {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: user.email, password: 'temporaryPassword')
              .then((cred) async {
            await FirebaseAuth.instance.currentUser?.delete();
          });
        }
      });

      // Xóa người dùng trên Firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .delete();

      // Sau khi xóa thành công, cập nhật lại danh sách người dùng
      getUsersByRole(user.role);
      AppSnackBarWidget()
          .setContent(const Text("Remove user success"))
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar(Get.context!);
      update();
    } catch (error) {
      Get.snackbar('Error', 'An error occurred while deleting the user.');
    }
  }

  Future<List<BookingModel>> getBookingsByUser(String userEmail) async {
    try {
      // Gọi API hoặc thực hiện logic lấy danh sách booking của người dùng trên Firebase
      final QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('user', isEqualTo: userEmail)
          .get();

      final List<BookingModel> bookings = bookingsSnapshot.docs
          .map((doc) =>
              BookingModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return bookings;
    } catch (error) {
      // Xử lý lỗi nếu có
      return [];
    }
  }
}

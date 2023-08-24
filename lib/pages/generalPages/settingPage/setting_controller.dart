import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_controller.dart';

class SettingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RxString currentPasswordError = RxString('');

  RxBool isCurrentObscure = true.obs;
  RxBool isNewObscure = true.obs;
  RxBool isConfirmObscure = true.obs;

  @override
  void onClose() {
    currentPasswordController.text = '';
    newPasswordController.text = '';
    confirmPasswordController.text = '';
  }

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          AuthCredential credentials = EmailAuthProvider.credential(
            email: user.email!,
            password: currentPasswordController.text,
          );

          try {
            await user.reauthenticateWithCredential(credentials);
            currentPasswordError.value = '';
            await user.updatePassword(newPasswordController.text);
          } catch (error) {
            currentPasswordError.value = "Current password is incorrect";
            print(error);
            return;
          }
        }
        Get.offAll(() => LoginPage());
        AppSnackBarWidget()
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.toastMessage)
            .setContent(const Text("Change password success"))
            .showSnackBar(Get.context!);
      } catch (error) {
        print(error);
        AppDefaultDialogWidget()
            .setContent("Something Went Wrong, Try later")
            .setIsHaveCloseIcon(true)
            .setAppDialogType(AppDialogType.error)
            .buildDialog(Get.context!)
            .show();
        rethrow;
      }
    }
  }

  Future<void> handleSignOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    Get.offAll(LoginPage());
  }
}

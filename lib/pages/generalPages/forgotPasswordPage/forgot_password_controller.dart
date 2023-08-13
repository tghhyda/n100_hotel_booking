import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';

part 'forgot_password_page.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  Future resetPassword(BuildContext context) async {
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      AppSnackBarWidget()
          .setContent(AppTextBody1Widget()
          .setText("Password reset email sent")
          .build(Get.context ?? context))
          .showSnackBar(Get.context ?? context);
    }on FirebaseAuthException catch(e){
      AppSnackBarWidget()
          .setContent(AppTextBody1Widget()
          .setText(e.message)
          .build(Get.context ?? context))
          .showSnackBar(Get.context ?? context);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/settingPage/setting_controller.dart';

class ChangePasswordView extends GetView<SettingController> {
  ChangePasswordView({super.key});

  @override
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Your Password"),
        backgroundColor: AppColorsExt.backgroundColor,
      ),
      body: Container(
        color: AppColorsExt.backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                ()=> AppTextFormFieldWidget()
                      .setController(controller.currentPasswordController)
                      .setHintText("Current password")
                      .setPrefixIcon(const Icon(Icons.lock_outline))
                      .setAutoValidateMode(AutovalidateMode.onUserInteraction)
                      .setObscureText(controller.isCurrentObscure.value)
                      .setOnTapSuffixIcon(() {
                        controller.isCurrentObscure.value =
                            !controller.isCurrentObscure.value;
                      })
                      .setValidator((value) {
                        if (value!.isEmpty) {
                          return "Please enter current password to change your change password";
                        }
                        if (controller.currentPasswordError.isNotEmpty) {
                          return controller.currentPasswordError.value;
                        }
                      })
                      .setDisplaySuffixIcon(true)
                      .build(context),
                ),
                const SizedBox(
                  height: 12,
                ),
                AppTextFormFieldWidget()
                    .setController(controller.newPasswordController)
                    .setHintText("New password")
                    .setPrefixIcon(const Icon(Icons.lock_outline))
                    .setAutoValidateMode(AutovalidateMode.onUserInteraction)
                    .setObscureText(controller.isNewObscure.value)
                    .setOnTapSuffixIcon(() {
                      controller.isNewObscure.value =
                          !controller.isNewObscure.value;
                    })
                    .setValidator((value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid password (min. 6 characters)";
                      } else {
                        return null;
                      }
                    })
                    .setDisplaySuffixIcon(true)
                    .build(context),
                const SizedBox(
                  height: 12,
                ),
                AppTextFormFieldWidget()
                    .setController(controller.confirmPasswordController)
                    .setHintText("Confirm new password")
                    .setPrefixIcon(const Icon(Icons.lock_outline))
                    .setAutoValidateMode(AutovalidateMode.onUserInteraction)
                    .setObscureText(controller.isConfirmObscure.value)
                    .setOnTapSuffixIcon(() {
                      controller.isConfirmObscure.value =
                          !controller.isConfirmObscure.value;
                    })
                    .setValidator((value) {
                      if (value != controller.newPasswordController.text) {
                        return "Confirm new password did not match";
                      }
                    })
                    .setDisplaySuffixIcon(true)
                    .build(context),
                const SizedBox(
                  height: 12,
                ),
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
                      await controller.changePassword();
                    },
                    child: AppTextBody1Widget()
                        .setTextStyle(AppTextStyleExt.of.textBody1s)
                        .setText("Change")
                        .build(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

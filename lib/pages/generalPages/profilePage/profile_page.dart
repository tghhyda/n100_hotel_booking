import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/dropdownButton/app_dropdown_button_second_type_widget.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/profilePage/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({super.key});

  @override
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isInitialized.value) {
        return Scaffold(
          backgroundColor: AppColorsExt.backgroundColor,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Your Profile"),
            actions: [
              controller.isEditMode.value
                  ? AppTextButtonWidget()
                      .setButtonText("View")
                      .setOnPressed(() {
                      controller.isEditMode.value =
                          !controller.isEditMode.value;
                    }).build(context)
                  : AppTextButtonWidget()
                      .setButtonText("Edit")
                      .setOnPressed(() {
                      controller.isEditMode.value =
                          !controller.isEditMode.value;
                    }).build(context)
            ],
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        // Căn giữa các widget trong Stack
                        children: [
                          // CircleAvatar for displaying the image
                          controller.avatarUrl.isNotEmpty == true
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(controller.avatarUrl.value),
                                  radius: 60,
                                )
                              : const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/defaultImage/user_default_avatar.png'),
                                  radius: 60,
                                ),
                          // IconButton on top of the CircleAvatar
                          if (controller.isEditMode.value)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 40,
                                  color: AppColors.of.yellowColor[5],
                                ),
                                onPressed: () async {
                                  await controller.pickImageAndUpload();
                                },
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      AppTextFormFieldWidget()
                          .setController(controller.emailController)
                          .setPrefixIcon(const Icon(Icons.mail))
                          .setHintText("Your email")
                          .setIsReadOnly(true)
                          .setAutoValidateMode(
                              AutovalidateMode.onUserInteraction)
                          .setValidator((value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty";
                        } else {
                          return null;
                        }
                      }).build(context),
                      SizedBox(
                        height: 12,
                      ),
                      AppTextFormFieldWidget()
                          .setController(controller.nameController)
                          .setPrefixIcon(const Icon(Icons.people))
                          .setHintText("Your name")
                          .setIsReadOnly(!controller.isEditMode.value)
                          .setAutoValidateMode(
                              AutovalidateMode.onUserInteraction)
                          .setValidator((value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty";
                        } else {
                          return null;
                        }
                      }).build(context),
                      const SizedBox(
                        height: 12,
                      ),
                      controller.isEditMode.value
                          ? Obx(
                              () => AppDropdownButtonSecondTypeWidget(
                                listItem: controller.listGenders,
                                labelText: "Gender",
                                selectedValue: controller.selectedGender.value,
                                onChanged: (value) {
                                  controller.selectedGender.value = value ??
                                      'Male'; // Cập nhật giá trị khi thay đổi
                                },
                              ).build(context),
                            )
                          : AppTextFormFieldWidget()
                              .setController(controller.genderController)
                              .setIsReadOnly(!controller.isEditMode.value)
                              .setPrefixIcon(const Icon(Icons.transgender))
                              .build(context),
                      const SizedBox(
                        height: 12,
                      ),
                      AppTextFormFieldWidget()
                          .setController(
                            TextEditingController(
                              text: DateFormat('dd/MM/yyyy').format(
                                  controller.selectedBirthDate.value ??
                                      DateTime.now()),
                            ),
                          )
                          .setDisplaySuffixIcon(false)
                          .setIsReadOnly(true)
                          .setPrefixIcon(const Icon(Icons.calendar_month))
                          .setOnTap(() {
                        if (controller.isEditMode.value) {
                          controller.selectDate(context);
                        }
                      }).build(context),
                      const SizedBox(
                        height: 12,
                      ),
                      AppTextFormFieldWidget()
                          .setHintText("Address")
                          .setController(controller.addressController)
                          .setPrefixIcon(const Icon(Icons.location_on))
                          .setDisplaySuffixIcon(false)
                          .setAutoValidateMode(
                              AutovalidateMode.onUserInteraction)
                          .setValidator((value) {
                            if (value!.isEmpty) {
                              return "Address cannot be empty";
                            } else {
                              return null;
                            }
                          })
                          .setIsReadOnly(!controller.isEditMode.value)
                          .build(context),
                      const SizedBox(
                        height: 12,
                      ),
                      AppTextFormFieldWidget()
                          .setController(controller.phoneController)
                          .setAutoValidateMode(
                              AutovalidateMode.onUserInteraction)
                          .setPrefixIcon(const Icon(Icons.phone))
                          .setIsReadOnly(!controller.isEditMode.value)
                          .setHintText("Phone Number")
                          .setValidator((value) {
                        if (value?.length != 10) {
                          return "Must be equal to 10 char";
                        }
                        return null;
                      }).build(context),
                      const SizedBox(
                        height: 20,
                      ),
                      if (controller.isEditMode.value)
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
                              if (controller.formKey.currentState!.validate()) {
                                controller.nameUser.value =
                                    controller.nameController.text;
                                controller.currentUser.value?.nameUser =
                                    controller.nameController.text;
                                controller.currentUser.value?.address =
                                    controller.addressController.text;
                                controller.currentUser.value?.phoneNumber =
                                    controller.phoneController.text;
                                controller.currentUser.value?.birthday =
                                    DateFormat('dd/MM/yyyy')
                                        .format(controller
                                                .selectedBirthDate.value ??
                                            DateTime.now())
                                        .toString();
                                controller.currentUser.value?.gender =
                                    controller.selectedGender.value;
                                await controller
                                    .updateUser(controller.currentUser.value!);
                                AppSnackBarWidget()
                                    .setContent(
                                        const Text("Update profile success"))
                                    .setAppSnackBarStatus(
                                        AppSnackBarStatus.success)
                                    .setAppSnackBarType(
                                        AppSnackBarType.toastMessage)
                                    .showSnackBar(Get.context!);
                              } else {
                                AppSnackBarWidget()
                                    .setContent(
                                        const Text("Update profile fail"))
                                    .setAppSnackBarStatus(
                                        AppSnackBarStatus.error)
                                    .setAppSnackBarType(
                                        AppSnackBarType.toastMessage)
                                    .showSnackBar(Get.context!);
                              }
                            },
                            child: AppTextBody1Widget()
                                .setTextStyle(AppTextStyleExt.of.textBody1s)
                                .setText("Save")
                                .build(context),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.of.yellowColor[5],
            ),
          ),
        );
      }
    });
  }
}

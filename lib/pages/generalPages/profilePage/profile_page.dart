import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
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
          appBar: AppBar(
            title: const Text("Your Profile"),
            actions: [
              AppTextButtonWidget().setButtonText("Edit").setOnPressed(() {
                controller.isEditMode.value = !controller.isEditMode.value;
              }).build(context)
            ],
          ),
          body: Column(
            children: [
              controller.currentUser?.imageUrl?.isNotEmpty == true
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage(controller.currentUser!.imageUrl!),
                      radius: 60,
                    )
                  : const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/defaultImage/user_default_avatar.png'),
                      radius: 60,
                    ),
              // Button to pick and update image
              ElevatedButton(
                onPressed: () {},
                child: const Text("Pick Image"),
              ),
            ],
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

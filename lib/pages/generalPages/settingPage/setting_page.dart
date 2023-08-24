import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/settingPage/components/item_card.dart';
import 'package:n100_hotel_booking/pages/generalPages/settingPage/setting_controller.dart';
import 'package:n100_hotel_booking/pages/generalPages/settingPage/views/change_password_view.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({super.key});

  @override
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      color: AppColorsExt.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              ItemCard(title: "Privacy Policy"),
              SizedBox(
                height: 8,
              ),
              ItemCard(title: "Terms & conditions")
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Column(
            children: [
              ItemCard(title: "About app"),
              SizedBox(
                height: 8,
              ),
              ItemCard(title: "Help & Support"),
              SizedBox(
                height: 8,
              ),
              ItemCard(title: "Rate My App"),
              SizedBox(
                height: 8,
              ),
              ItemCard(title: "Faq?")
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ItemCard(
            title: "Change Your Password",
            onTap: () {
              Get.to(() => ChangePasswordView());
            },
          ),
          const Spacer(),
          ItemCard(
            title: "Logout",
            onTap: () {
              controller.handleSignOut();
            },
          ),
        ],
      ),
    );
  }
}

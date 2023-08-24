import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/generalPages/profilePage/profile_controller.dart';
import 'package:n100_hotel_booking/pages/generalPages/profilePage/profile_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/settingPage/setting_page.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/history_page.dart';
import 'package:n100_hotel_booking/pages/userPages/screens/user_home_page.dart';

class UserHome extends GetView<ProfileController> {
  final RxInt _currentPageIndex = 0.obs;

  @override
  final controller = Get.put(ProfileController());

  final List<Widget> _pages = [UserHomePage(), HistoryPage(), SettingPage()];

  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isInitialized.value) {
        return Scaffold(
          backgroundColor: Colors.white, // Set background color to white
          appBar: AppBar(
            backgroundColor: AppColorsExt.backgroundColor,
            elevation: 1,
            title: Row(
              children: [
                Icon(
                  Icons.home_outlined,
                  size: 40,
                  color: AppColors.of.yellowColor[6],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextBody1Widget()
                        .setText("N100")
                        .setColor(AppColors.of.yellowColor[6])
                        .build(context),
                    AppTextBody1Widget()
                        .setText("Hotel Booking")
                        .setColor(AppColors.of.yellowColor[6])
                        .setTextStyle(AppTextStyleExt.of.textBody1s)
                        .build(context)
                  ],
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  AppTextBody1Widget()
                      .setText(controller.nameUser.value)
                      .build(context),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProfilePage());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: controller.avatarUrl.isNotEmpty == true
                          ? Image.network(
                              controller.avatarUrl.value,
                              height: 35,
                              width: 35,
                            )
                          : Image.asset(
                              'assets/defaultImage/user_default_avatar.png',
                              height: 35,
                              width: 35,
                            ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 12,
              )
            ],
          ),
          body: _pages[_currentPageIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPageIndex.value,
            onTap: (index) {
              _currentPageIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
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

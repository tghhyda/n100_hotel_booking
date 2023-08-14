import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/userPages/screens/user_home_page.dart';
import 'package:n100_hotel_booking/pages/userPages/screens/user_setting.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';

class UserHome extends GetView<UserController> {
  final RxInt _currentPageIndex = 0.obs;

  @override
  final controller = Get.put(UserController());

  final List<Widget> _pages = [UserHomePage(), const UserSetting()];

  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsExt.backgroundColor,
        appBar: AppBar(
          title: const Text('User'),
          backgroundColor: Colors.transparent,
        ),
        body: _pages[_currentPageIndex.value],
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
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
                icon: Icon(Icons.account_circle),
                label: 'User',
              ),
            ],
          ),
        ));
  }
}

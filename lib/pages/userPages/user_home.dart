import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/history_page.dart';
import 'package:n100_hotel_booking/pages/userPages/screens/user_home_page.dart';
import 'package:n100_hotel_booking/pages/userPages/screens/user_setting.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';

class UserHome extends GetView<UserController> {
  final RxInt _currentPageIndex = 0.obs;

  @override
  final controller = Get.put(UserController());

  final List<Widget> _pages = [UserHomePage(), HistoryPage(), UserSetting()];

  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsExt.backgroundColor,
        appBar: AppBar(
          title: Text('${FirebaseAuth.instance.currentUser?.displayName}'),
          backgroundColor: AppColorsExt.backgroundColor,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  controller.handleSignOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Obx(() => _pages[_currentPageIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: _currentPageIndex.value,
            onTap: (index) {
              _currentPageIndex.value = index;
              print("Qqqqqqqqqqqqqqqqqqqqqqqqqqqq");
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
                icon: Icon(Icons.account_circle),
                label: 'User',
              ),
            ],
          ),
        ));
  }
}

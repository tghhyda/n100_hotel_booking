import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/adminPages/bookingManagement/admin_booking_management.dart';
import 'package:n100_hotel_booking/pages/adminPages/otherManagement/admin_others_model_management.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/admin_room_management_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/userManagement/admin_user_management_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_controller.dart';
import 'package:get/get.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminOthersModelManagement(),
    const AdminBookingManagement(),
    const AdminHomePage(),
    AdminRoomManagementPage(),
    const AdminUserManagementPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin',
          style: TextStyle(color: AppColorsExt.textColor),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColorsExt.backgroundColor,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.logout),
            onPressed: () {
              signOutUser();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColorsExt.bottomNavigationBarColor,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Models'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_business_sharp),
              label: 'Booking'),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bed),
            label: 'Room',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'User',
          ),
        ],
      ),
    );
  }

  void signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Đăng xuất thành công, chuyển đến trang đăng nhập
      Navigator.pushAndRemoveUntil(
        Get.context ?? context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Xảy ra lỗi khi đăng xuất
      print("Lỗi đăng xuất: $e");
    }
  }
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}

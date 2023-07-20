import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_room_management_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_user_management_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/loginPage/login_page.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AdminHomePage(),
    const AdminRoomManagementPage(),
    const AdminUserManagementPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin',
          style: TextStyle(color: Colors.white),
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
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        // Thay thế bằng trang đăng nhập của bạn
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Xảy ra lỗi khi đăng xuất
      print("Lỗi đăng xuất: $e");
    }
  }
}

class AdminHomePage extends StatelessWidget {
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

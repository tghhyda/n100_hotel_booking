import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/user_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/register_for_staff_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/add_room_page.dart';

class AdminUserManagementPage extends StatefulWidget {
  const AdminUserManagementPage({Key? key}) : super(key: key);

  @override
  State<AdminUserManagementPage> createState() =>
      _AdminUserManagementPageState();
}

class _AdminUserManagementPageState extends State<AdminUserManagementPage> {
  TextEditingController searchController = TextEditingController();

  List<UserModel> filteredUserList = [];

  void fetchUserList() async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isNotEqualTo: 'Admin')
        .get();
    List<UserModel> users = userSnapshot.docs.map((doc) {
      String name = doc['name'] as String;
      String email = doc['email'] as String;
      String address = doc['address'] as String;
      String phone = doc['phone'] as String;
      String birthday = doc['birthday'] as String;
      String imageUrl = doc['imageUrl'] as String;
      String role = doc['role'] as String;
      return UserModel(name, birthday, phone, imageUrl, role, email, address);
    }).toList();
    setState(() {
      filteredUserList = users;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserList();
  }

  void searchRooms(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        filteredUserList = [];
      });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .where('role', isNotEqualTo: 'Admin')
          .where('name', isGreaterThanOrEqualTo: keyword)
          .where('name', isLessThan: '${keyword}z')
          .get()
          .then((QuerySnapshot querySnapshot) {
        List<UserModel> filteredUsers = querySnapshot.docs.map((doc) {
          String name = doc['name'] as String;
          String email = doc['email'] as String;
          String address = doc['address'] as String;
          String phone = doc['phone'] as String;
          String birthday = doc['birthday'] as String;
          String imageUrl = doc['imageUrl'] as String;
          String role = doc['role'] as String;
          return UserModel(
              name, birthday, phone, imageUrl, role, email, address);
        }).toList();
        setState(() {
          filteredUserList = filteredUsers;
        });
      });
    }
  }

  void _deleteUser(UserModel userModel) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userModel.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      searchRooms(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterForStaff(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredUserList.length,
            itemBuilder: (context, index) {
              UserModel user = filteredUserList[index];
              return Card(
                color: Colors.white60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.withOpacity(0.2),
                          // Replace with your image widget
                          child: Image.network(
                            user.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.nameUser,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(user.email),
                            Text(user.role),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteUser(user);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

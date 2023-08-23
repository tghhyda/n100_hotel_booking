import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/userManagement/detail_user_page.dart';

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
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isNotEqualTo: 'Admin')
          .get();

      List<UserModel> users = userSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson(data);
      }).toList();

      setState(() {
        filteredUserList = users;
      });
    } catch (_) {
      rethrow;
    }
  }


  @override
  void initState() {
    super.initState();
    fetchUserList();
  }

  void searchUser(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        fetchUserList();
      });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .where('role', isNotEqualTo: 'Admin')
          .get()
          .then((QuerySnapshot querySnapshot) {
        List<UserModel> filteredUsers = querySnapshot.docs
            .where((doc) => doc['name'].startsWith(keyword))
            .map((doc) {
          String name = doc['name'] as String;
          String email = doc['email'] as String;
          String address = doc['address'] as String;
          String phone = doc['phone'] as String;
          String birthday = doc['birthday'] as String;
          String imageUrl = doc['imageUrl'] as String;
          String role = doc['role'] as String;
          String gender = doc['gender'] as String;
          return UserModel(
              nameUser: name,
              birthday: birthday,
              phoneNumber: phone,
              imageUrl: imageUrl,
              role: role,
              email: email,
              address: address,
              gender: gender);
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

  void _navigateToUserDetail(UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailPage(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColorsExt.backgroundColor,
      child: Column(
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
                        searchUser(value);
                      },
                      style: const TextStyle(
                        color: AppColorsExt.textColor,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColorsExt.textColor,
                        ),
                        labelStyle: const TextStyle(
                          color: AppColorsExt.textColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                return InkWell(
                  onTap: () {
                    _navigateToUserDetail(user);
                  },
                  child: Card(
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
                                user.imageUrl!,
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
                                  user.nameUser!,
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
                          // IconButton(
                          //   onPressed: () {
                          //     _deleteUser(user);
                          //   },
                          //   icon: const Icon(Icons.delete),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

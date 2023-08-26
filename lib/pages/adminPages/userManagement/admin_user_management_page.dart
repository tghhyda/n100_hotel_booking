import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/userManagement/admin_add_staff.dart';
import 'package:n100_hotel_booking/pages/adminPages/userManagement/admin_user_management_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/userManagement/detail_user_page.dart';

class AdminUserManagementPage extends GetView<AdminUserManagementController> {
  AdminUserManagementPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  final controller = Get.put(AdminUserManagementController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: AppColorsExt.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColorsExt.backgroundColor,
          actions: [
            IconButton(onPressed: (){
              Get.to(()=> const RegisterStaff());
            }, icon: const Icon(Icons.add))
          ],
          title: AppTextBody1Widget()
              .setText("User Management").build(context),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Users'),
              Tab(text: 'Staff'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserList(role: 'User'),
            _buildUserList(role: 'Staff'),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList({required String role}) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColorsExt.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ... Your search TextField and other UI elements ...

          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: controller.getUsersByRole(role),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No users found.');
                } else {
                  List<UserModel> userList = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      UserModel user = userList[index];
                      return InkWell(
                        onTap: () {
                          Get.to(() => UserDetailPage(user: user));
                        },
                        child: Card(
                          elevation: 2,
                          // Add some elevation for a card-like appearance
                          child: ListTile(
                            leading: SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: user.imageUrl!.isNotEmpty
                                    ? Image.network(
                                        user.imageUrl!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/defaultImage/user_avatar.png',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            title: Text(user.nameUser!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: ${user.email}"),
                                Text("Role: ${user.role}"),
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'delete') {
                                  AppDefaultDialogWidget()
                                      .setAppDialogType(AppDialogType.confirm)
                                      .setNegativeText("No")
                                      .setPositiveText("Yes")
                                      .setTitle("CONFIRM DELETE USER")
                                      .setContent(
                                          "Are you sure to remove this user?")
                                      .setOnPositive(() {
                                        controller.deleteUser(user);
                                      })
                                      .buildDialog(context)
                                      .show();
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

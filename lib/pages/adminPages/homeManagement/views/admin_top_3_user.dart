import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/homeManagement/admin_home_controller.dart';

class AdminTop3User extends GetView<AdminHomeController> {
  AdminTop3User({super.key});

  @override
  final controller = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextBody1Widget()
            .setText("TOP 3 USERS WITH THE MOST BOOKINGS")
            .setColor(AppColors.of.redColor[6])
            .setMaxLines(2)
            .setTextOverFlow(TextOverflow.ellipsis)
            .build(context),
        const Divider(),
        Expanded(
          child: FutureBuilder<List<UserModel>>(
            future: controller.findTop3Users(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No users found');
              } else {
                List<UserModel> topUsers = snapshot.data!;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: topUsers.length,
                  itemBuilder: (context, index) {
                    final user = topUsers[index];
                    final imageUrl = user.imageUrl != null
                        ? user.imageUrl! // Sử dụng hình ảnh đại diện nếu có
                        : 'assets/default_avatar.png'; // Hình ảnh mặc định từ asset

                    return Column(
                      children: [
                        AppTextBody1Widget()
                            .setText("TOP ${index + 1}")
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .setColor(AppColors.of.yellowColor[7])
                            .build(context),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Uri.tryParse(imageUrl) != null
                              ? InkWell(
                                  onTap: () {
                                    // Xử lý khi nhấn vào hình ảnh
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    // Xử lý khi nhấn vào hình ảnh
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}

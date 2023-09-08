import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/homeManagement/admin_home_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/admin_room_view_detail.dart';

class AdminTop3Room extends GetView<AdminHomeController> {
  AdminTop3Room({super.key});

  @override
  final controller = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextBody1Widget()
            .setText("TOP 3 MOST BOOKED ROOM ALL THE TIME")
            .setColor(AppColors.of.redColor[6])
            .setMaxLines(2)
            .setTextOverFlow(TextOverflow.ellipsis)
            .build(context),
        const Divider(),
        Expanded(
          child: FutureBuilder<List<RoomModel>>(
            future: controller.findTop3Rooms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Hiển thị tiêu đề tải dữ liệu khi đang đợi Future hoàn thành.
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Xử lý lỗi nếu có.
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text(
                    'No rooms found'); // Xử lý trường hợp không có phòng nào.
              } else {
                List<RoomModel> topRooms =
                    snapshot.data!; // Lấy danh sách phòng từ snapshot

                // Hiển thị danh sách phòng
                return ListView.builder(
                  scrollDirection: Axis.vertical, // Đặt hướng cuộn là ngang
                  itemCount: topRooms.length,
                  itemBuilder: (context, index) {
                    final room = topRooms[index];
                    final imageUrl = room.images != null &&
                            room.images!.isNotEmpty
                        ? room.images![0] // Lấy ảnh đầu tiên nếu có
                        : 'assets/adsImage/room4.png'; // Ảnh mặc định từ asset

                    return Column(
                      children: [
                        AppTextBody1Widget()
                            .setText("TOP ${index + 1}")
                            .setTextStyle(AppTextStyleExt.of.textBody1s)
                            .setColor(AppColors.of.yellowColor[7])
                            .build(context),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Uri.tryParse(imageUrl!) != null
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => AdminRoomDetailPage(),
                                        arguments: topRooms[index]);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Get.to(() => AdminRoomDetailPage(),
                                        arguments: topRooms[index]);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                        ),
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

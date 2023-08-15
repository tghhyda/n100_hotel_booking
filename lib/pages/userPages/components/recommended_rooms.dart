import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_url_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';

class RecommendedRooms extends GetView<UserController> {
  RecommendedRooms({super.key});

  @override
  final controller = Get.put(UserController());

  Future<List<RoomModel>> fetchRoomList() async {
    List<RoomModel> roomList = await controller.fetchRoomList();
    return roomList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              AppTextBody1Widget().setText("Recommended").build(context),
              const Spacer(),
              AppTextButtonWidget()
                  .setButtonText("View all")
                  .setOnPressed(() {})
                  .build(context)
            ],
          ),
          FutureBuilder<List<RoomModel>>(
            future: fetchRoomList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<RoomModel> roomList = snapshot.data!;
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Đặt hướng cuộn là ngang
                    itemCount: roomList.length,
                    itemBuilder: (BuildContext context, int index) {
                      RoomModel room = roomList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // Điều chỉnh góc bo tròn tùy theo nhu cầu
                          side: const BorderSide(
                            color: Colors.grey, // Màu viền
                            width: 1, // Độ dày của viền
                          ),
                        ),
                        shadowColor: AppColors.of.grayColor[10],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            room.images!.isNotEmpty
                                ? Image.network(
                                    room.images![0]!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/adsImage/room2.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                            const SizedBox(
                              height: 4,
                            ),
                            AppTextBody1Widget()
                                .setText(room.typeRoom.nameTypeRoom)
                                .setTextOverFlow(TextOverflow.ellipsis)
                                .setMaxLines(1)
                                .build(context)
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text('No data available.'));
              }
            },
          )
        ],
      ),
    );
  }
}

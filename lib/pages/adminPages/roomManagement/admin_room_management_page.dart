import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/add_room_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/admin_room_view_detail.dart';

class AdminRoomManagementPage extends GetView<AdminController> {
  @override
  final controller = Get.put(AdminController());

  AdminRoomManagementPage({super.key});

  TextEditingController searchController = TextEditingController();

  Future<List<RoomModel>> fetchRoomList() async {
    List<RoomModel> roomList = await controller.fetchRoomList();
    return roomList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        // searchRooms(value);
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        labelText: 'Search',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
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
                        Get.to(() => AddRoomPage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
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
            child: FutureBuilder<List<RoomModel>>(
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
                      scrollDirection: Axis.vertical, // Đặt hướng cuộn là ngang
                      itemCount: roomList.length,
                      itemBuilder: (BuildContext context, int index) {
                        RoomModel room = roomList[index];
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => AdminRoomDetailPage(),
                              arguments:
                                  room, // Pass your RoomModel object here
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.of.grayColor[1],
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.of.grayColor[7]!
                                        .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(1, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: room.images!.isNotEmpty
                                        ? Image.network(
                                            room.images![0]!,
                                            // Thay thế bằng URL hình ảnh thực tế của phòng
                                            width: 100,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/adsImage/room4.png",
                                            width: 100,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextBody1Widget()
                                            .setText(
                                                "${room.typeRoom.nameTypeRoom}")
                                            .setTextStyle(
                                                AppTextStyleExt.of.textBody1s)
                                            .build(context),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color:
                                                  AppColors.of.yellowColor[5],
                                              size: 20,
                                            ),
                                            AppTextSubTitle1Widget()
                                                .setText(controller
                                                    .getRating(room)
                                                    .toStringAsFixed(1))
                                                .setColor(
                                                    AppColors.of.grayColor[6])
                                                .build(context),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            AppTextSubTitle1Widget()
                                                .setText(
                                                    "Reviews (${room.review!.length})")
                                                .setColor(
                                                    AppColors.of.grayColor[6])
                                                .build(context)
                                          ],
                                        ),
                                        AppTextSubTitle1Widget()
                                            .setText(room.description)
                                            .setMaxLines(3)
                                            .setTextOverFlow(
                                                TextOverflow.ellipsis)
                                            .setColor(AppColors.of.grayColor[7])
                                            .build(context),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        AppTextSubTitle1Widget()
                                            .setText(
                                                "${room.priceRoom} VND / Night")
                                            .build(context),
                                        FutureBuilder<int>(
                                          future: controller.countBookingsByRoom(room.idRoom),
                                          builder: (context, bookingSnapshot) {
                                            if (bookingSnapshot.connectionState == ConnectionState.waiting) {
                                              return const Text('Loading...');
                                            } else if (bookingSnapshot.hasError) {
                                              return Text('Error: ${bookingSnapshot.error}');
                                            } else if (bookingSnapshot.hasData) {
                                              int bookingCount = bookingSnapshot.data!;
                                              return AppTextSubTitle1Widget()
                                                  .setText("Booking Count: $bookingCount")
                                                  .build(context);  // Display bookingCount here as text
                                            } else {
                                              return const Text('No data available.');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

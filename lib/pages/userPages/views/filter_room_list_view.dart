import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';
import 'package:n100_hotel_booking/pages/userPages/booking/room_detail_page.dart';

class FilterRoomListView extends GetView<UserController> {
  FilterRoomListView({super.key});

  @override
  final controller = Get.put(UserController());

  TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColorsExt.backgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextBody1Widget()
                .setText("N100")
                .setTextStyle(AppTextStyleExt.of.textBody1s)
                .build(context),
            AppTextSubTitle1Widget().setText("Hotel Booking").build(context)
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.location_on_outlined,
                color: AppColors.of.yellowColor[5],
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController, // Đặt controller
              decoration: InputDecoration(
                labelText: 'Search by room name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.of.yellowColor[5],
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
              ),
              onChanged: (value) async {
                searchQuery.value = value;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Obx(
                () => FutureBuilder<List<RoomModel>>(
                  future: controller.filterByName(searchQuery.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text("No rooms match the search criteria."));
                    } else {
                      final List<RoomModel> filteredRooms = snapshot.data!;
                      return RefreshIndicator(
                        onRefresh: () async {
                          await controller.filterByName(searchQuery.value);
                        },
                        child: ListView.builder(
                          itemCount: filteredRooms.length,
                          itemBuilder: (context, index) {
                            final RoomModel room = filteredRooms[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => const RoomDetailPage(),
                                    arguments:
                                        room, // Pass your RoomModel object here
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.of.grayColor[1],
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
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
                                                width: 80,
                                                height: 100,
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
                                                .setTextStyle(AppTextStyleExt
                                                    .of.textBody1s)
                                                .build(context),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors
                                                      .of.yellowColor[5],
                                                  size: 20,
                                                ),
                                                AppTextSubTitle1Widget()
                                                    .setText(
                                                        '${controller.getRating(room)}')
                                                    .setColor(AppColors
                                                        .of.grayColor[6])
                                                    .build(context),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                AppTextSubTitle1Widget()
                                                    .setText(
                                                        "Reviews (${room.review!.length})")
                                                    .setColor(AppColors
                                                        .of.grayColor[6])
                                                    .build(context)
                                              ],
                                            ),
                                            Text(
                                              '${room.description}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            // AppTextSubTitle1Widget()
                                            //     .setText(room.description)
                                            //     .setMaxLines(3)
                                            //     .setTextOverFlow(
                                            //         TextOverflow.ellipsis)
                                            //     .setColor(
                                            //         AppColors.of.grayColor[7])
                                            //     .build(context),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            AppTextSubTitle1Widget()
                                                .setText(
                                                    "${room.priceRoom} VND / Night")
                                                .build(context),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: AppColors
                                                      .of.yellowColor[5],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                        width: 1,
                                                        color: AppColors.of
                                                                    .grayColor[
                                                                10] ??
                                                            Colors
                                                                .black), // Thay đổi border radius ở đây
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: AppTextSubTitle1Widget()
                                                    .setText("Book now")
                                                    .build(context))
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
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

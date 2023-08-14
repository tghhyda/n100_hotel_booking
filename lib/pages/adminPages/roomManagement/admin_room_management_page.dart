import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/constants/app_url_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/add_room_page.dart';

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
                        Get.to(()=> AddRoomPage());
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
                              Image.network(
                                room.images![0]!,
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
            ),
          ),
        ],
      ),
    );
  }

}

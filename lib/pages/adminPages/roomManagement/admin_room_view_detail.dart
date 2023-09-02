import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/add_entity_room_page/admin_room_add_entity_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/edit_room_page/edit_room_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/room_list_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/views/admin_room_detail_description_view.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/views/admin_room_detail_photo_view.dart';
import 'package:n100_hotel_booking/pages/adminPages/roomManagement/views/admin_room_detail_review_view.dart';
import 'package:n100_hotel_booking/pages/userPages/bookingPage/booking_page.dart';

class AdminRoomDetailPage extends GetView<AdminController> {
  AdminRoomDetailPage({super.key});

  @override
  final controller = Get.put(AdminController());

  final roomListController = Get.put(RoomListController());

  final RoomModel room = Get.arguments;

  @override
  Widget build(BuildContext context) {
    int numberOfPhoto = room.images!.isEmpty ? 4 : room.images!.length;
    return Scaffold(
      body: DefaultTabController(
        length: 3, // Số lượng tab
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              expandedHeight: 200,
              actions: [
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'editRoom',
                        child: Text('Edit room'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'deleteRoom',
                        child: Text('Delete room'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'addRoom',
                        child: Text('Add entity room'),
                      ),
                    ];
                  },
                  onSelected: (String result) {
                    if (result == 'editRoom') {
                      Get.to(() => EditRoomPage(), arguments: room);
                    }
                    if (result == 'deleteRoom') {
                      AppDefaultDialogWidget()
                          .setAppDialogType(AppDialogType.confirm)
                          .setTitle("Confirm Delete Room")
                          .setContent("Are you sure to delete this room?")
                          .setNegativeText("No")
                          .setPositiveText("Yes")
                          .setOnPositive(() async {
                            await controller
                                .deleteRoomAndCheckBooking(room.idRoom);
                          })
                          .buildDialog(context)
                          .show();
                    }
                    if (result == 'addRoom') {
                      Get.to(() => AdminRoomAddEntityPage(), arguments: room);
                    }
                  },
                ),
              ],
              title: AppTextBody1Widget()
                  .setText("${room.typeRoom.nameTypeRoom}")
                  .setTextStyle(AppTextStyleExt.of.textBody1s)
                  .setColor(AppColors.of.grayColor[10])
                  .build(context),
              flexibleSpace: FlexibleSpaceBar(
                background: room.images!.isNotEmpty
                    ? Image.network(
                        room.images![0]!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/adsImage/room4.png',
                        fit: BoxFit.cover,
                      ),
                titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
                title: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.of.yellowColor[5],
                      size: 20,
                    ),
                    AppTextSubTitle1Widget()
                        .setText(controller.getRating(room).toStringAsFixed(1))
                        .setColor(AppColors.of.grayColor[1])
                        .build(context),
                    const SizedBox(
                      width: 12,
                    ),
                    AppTextSubTitle1Widget()
                        .setText('${room.review?.length} reviews')
                        .setColor(AppColors.of.grayColor[1])
                        .build(context),
                  ],
                ),
              ),
              pinned: true,
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  tabs: [
                    Tab(text: 'Reviews (${room.review?.length})'),
                    Tab(text: 'Photos ($numberOfPhoto)'),
                    const Tab(text: 'Description'),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  // Nội dung cho tab Review
                  AdminRoomDetailReviewView(roomModel: room),
                  // Nội dung cho tab Photo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AdminRoomDetailPhotoView(
                      listImage: room.images,
                    ),
                  ),
                  // Nội dung cho tab Description
                  AdminRoomDetailDescriptionView(
                    bodyDescription: Text(room.description),
                    roomModel: room,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

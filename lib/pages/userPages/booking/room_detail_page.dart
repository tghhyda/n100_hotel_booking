import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';
import 'package:n100_hotel_booking/pages/userPages/views/room_detail_description_view.dart';
import 'package:n100_hotel_booking/pages/userPages/views/room_detail_review_view.dart';

import '../views/room_detail_photo_view.dart';

class RoomDetailPage extends GetView<UserController> {
   RoomDetailPage({super.key});

  @override
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final RoomModel room = Get.arguments;
    int numberOfPhoto = room.images!.isEmpty ? 4 : room.images!.length;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // await update();
        },
        child: DefaultTabController(
          length: 3, // Số lượng tab
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                expandedHeight: 200,
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
                          .setText('${controller.getRating(room)}')
                          .setColor(AppColors.of.grayColor[1])
                          .build(context),
                      const SizedBox(
                        width: 12,
                      ),
                      AppTextSubTitle1Widget()
                          .setText('${room.review?.length} people reviewed')
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
                    RoomDetailReviewView(listReview: room!.review),
                    // Nội dung cho tab Photo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: RoomDetailPhotoView(
                        listImage: room.images,
                      ),
                    ),
                    // Nội dung cho tab Description
                    RoomDetailDescriptionView(
                      bodyDescription: Text(room.description),
                      roomModel: room,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextBody1Widget()
                      .setText('${room.priceRoom} VND')
                      .build(context),
                  AppTextBody1Widget().setText('AVG/NIGHT').build(context),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lime, Colors.amber],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: AppTextButtonWidget()
                    .setButtonText("BOOKING NOW")
                    .setOnPressed(() {})
                    .build(context),
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

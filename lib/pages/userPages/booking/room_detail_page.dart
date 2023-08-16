import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';
import 'package:n100_hotel_booking/pages/userPages/views/room_detail_description_view.dart';

class RoomDetailPage extends GetView<UserController> {
  const RoomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RoomModel room = Get.arguments;

    return DefaultTabController(
      length: 3, // Số lượng tab
      child: Scaffold(
        body: CustomScrollView(
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
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Review (${room.review?.length})'),
                      Tab(text: 'Photo (${room.images?.length})'),
                      const Tab(text: 'Description'),
                    ],
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  // Nội dung cho tab Review
                  Center(
                    child: AppTextBody1Widget()
                        .setText('Review (${room.review?.length})')
                        .build(context),
                  ),
                  // Nội dung cho tab Photo
                  const Center(
                    child: Text('Phooooto'),
                  ),
                  // Nội dung cho tab Description
                  RoomDetailDescriptionView(
                    bodyDescription: Text(room.description),
                    listConvenient: room.convenient,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                // color: Colors.redAccent,
                border: Border.all(width: 1, color: Colors.grey)),
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
                )
              ],
            )),
      ),
    );
  }
}

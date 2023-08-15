import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/pages/userPages/components/pick_number_widget.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';

class SearchRoomDetail extends GetView<UserController> {
  SearchRoomDetail({super.key});

  @override
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text("Guess and Room"),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PickNumberWidget(
                prefixIcon: const Icon(Icons.door_back_door_outlined),
                theNumberOfX: controller.theNumberOfRooms ?? 0.obs,
                title: "The number of room"),
            Divider(
              thickness: 1,
              color: AppColors.of.grayColor[7],
            ),
            PickNumberWidget(
                prefixIcon: const Icon(Icons.people_outline),
                theNumberOfX: controller.theNumberOfAdult ?? 0.obs,
                title: "The number of adult"),
            Divider(
              thickness: 1,
              color: AppColors.of.grayColor[7],
            ),
            PickNumberWidget(
                prefixIcon: const Icon(Icons.child_care),
                theNumberOfX: controller.theNumberOfChildren ?? 0.obs,
                title: "The number of children"),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.of.yellowColor[5],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Get.back(result: {
                      'theNumberOfAdult':
                          controller.theNumberOfAdult?.value ?? 0,
                      'room': controller.theNumberOfRooms?.value ?? 0,
                      'children': controller.theNumberOfChildren?.value ?? 0,
                    });
                    print('${controller.theNumberOfAdult?.value}');
                  },
                  child: AppTextBody1Widget()
                      .setTextStyle(AppTextStyleExt.of.textBody1s)
                      .setText("Select")
                      .build(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

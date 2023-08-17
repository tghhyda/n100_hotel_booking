import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/pages/userPages/views/room_post_review_view.dart';

class RoomDetailReviewView extends StatelessWidget {
  RoomDetailReviewView({Key? key, required this.roomModel}) : super(key: key);

  final RoomModel roomModel;

  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        await controller.getListReviewsForRoom(roomModel.idRoom);
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextBody1Widget()
                      .setText("Rate this room")
                      .setTextStyle(AppTextStyleExt.of.textBody1s)
                      .build(context),
                  AppTextSubTitle1Widget()
                      .setText("Let others know what you think")
                      .setColor(AppColors.of.grayColor[7])
                      .build(context),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 1; i <= 5; i++)
                          GestureDetector(
                            onTap: () {
                              controller.rating?.value = i;
                              Get.to(RoomPostReviewView(), arguments: roomModel);
                            },
                            child: Icon(
                              i <= controller.rating!.value
                                  ? Icons.star
                                  : Icons.star_outline,
                              size: 35,
                              color: i <= controller.rating!.value
                                  ? Colors.orange
                                  : Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextButtonWidget()
                      .setButtonText("Write a review")
                      .setOnPressed(() {
                    Get.to(RoomPostReviewView(), arguments: roomModel);
                  }).build(context)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 16),
              child: AppTextBody1Widget()
                  .setText("Rating and reviews")
                  .setTextStyle(AppTextStyleExt.of.textBody1s)
                  .build(context),
            ),
            for (int i = 5; i >= 1; i--) _buildReviewRow(i),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: FutureBuilder<List<ReviewModel>>(
                future: controller.getListReviewsForRoom(roomModel.idRoom),
                // Gọi hàm để lấy danh sách review
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Hiển thị biểu tượng chờ khi đang tải dữ liệu
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi xảy ra
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                        'No reviews available'); // Hiển thị thông báo khi không có review
                  } else {
                    List<ReviewModel> reviews = snapshot.data!;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var review in reviews) _buildReviewItem(review),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(ReviewModel review) {
    double rate = review.rate; // Get the rate from the review
    int fullStars = rate.toInt();
    int outlinedStars = 5 - fullStars;
    String formattedTime = DateFormat('dd/MM/yyyy').format(review.timeReview);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextBody1Widget()
            .setText(review.user)
            .setColor(AppColors.of.grayColor[8])
            .build(Get.context!),
        Row(
          children: [
            // Display full stars
            for (int i = 0; i < fullStars; i++)
              Icon(
                Icons.star,
                color: AppColors.of.yellowColor[5],
                size: 20,
              ),
            // Display outlined stars
            for (int i = 0; i < outlinedStars; i++)
              Icon(
                Icons.star_outline,
                color: AppColors.of.grayColor[5],
                size: 20,
              ),
            const SizedBox(
              width: 8,
            ),
            AppTextSubTitle1Widget()
                .setText(formattedTime)
                .setColor(AppColors.of.grayColor[7])
                .build(Get.context!),
          ],
        ),
        Flexible(
          child: AppTextSubTitle1Widget()
              .setText(review.detailReview)
              .setColor(AppColors.of.grayColor[7])
              .setMaxLines(3)
              .setTextOverFlow(TextOverflow.ellipsis)
              .build(Get.context!),
        ),
        // Add any additional information you want to display for each review
        Divider(), // Add a divider between reviews
      ],
    );
  }

  Widget _buildReviewRow(int starCount) {
    int? numberOfReviewsWithStar =
        roomModel.review?.where((review) => review?.rate == starCount).length ??
            0;
    double progressValue =
        roomModel.review != null && roomModel.review!.isNotEmpty
            ? numberOfReviewsWithStar / roomModel.review!.length
            : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      color: AppColors.of.grayColor[3],
      child: Row(
        children: [
          Text('$starCount star'),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progressValue,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          const SizedBox(width: 8),
          Text('$numberOfReviewsWithStar reviews'),
        ],
      ),
    );
  }
}

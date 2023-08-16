import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class RoomDetailReviewView extends StatelessWidget {
  const RoomDetailReviewView({Key? key, required this.listReview})
      : super(key: key);

  final List<ReviewModel?>? listReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 5; i >= 1; i--) _buildReviewRow(i),
      ],
    );
  }

  Widget _buildReviewRow(int starCount) {
    int? numberOfReviewsWithStar = listReview?.where((review) => review?.rate == starCount).length ?? 0;
    double progressValue = listReview != null && listReview!.isNotEmpty ? numberOfReviewsWithStar/ listReview!.length : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8.0),
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

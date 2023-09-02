import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({super.key, required this.listImage});

  final List<dynamic> listImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: AnotherCarousel(
          images: listImage,
          dotPosition: DotPosition.topCenter,
          dotSpacing: 16,
          dotIncreasedColor: AppColors.of.yellowColor[6]!),
    );
  }
}

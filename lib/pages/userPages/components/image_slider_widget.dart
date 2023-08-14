import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: AnotherCarousel(
        images: const [
          AssetImage('assets/adsImage/ad1.png'),
          AssetImage('assets/adsImage/ad2.png'),
          AssetImage('assets/adsImage/ad3.png'),
        ],
      ),
    );
  }
}

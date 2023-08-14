import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class SquareTileWidget extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const SquareTileWidget({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.of.grayColor[7]!),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.of.grayColor[1]
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}

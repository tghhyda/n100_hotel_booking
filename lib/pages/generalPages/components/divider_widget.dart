import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, required this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Divider(
                color: Colors.grey, // Màu của đường kẻ ngang
                height: 1,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: AppTextBody1Widget()
                    .setText(title ?? '')
                    .setColor(AppColors.of.grayColor[7])
                    .build(context)),
            const Expanded(
              child: Divider(
                color: Colors.grey, // Màu của đường kẻ ngang
                height: 1,
              ),
            ),
          ],
        ));
  }
}

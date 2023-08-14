import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/button/app_button_base_builder.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class PickNumberWidget extends StatelessWidget {
  const PickNumberWidget(
      {super.key,
      required this.prefixIcon,
      required this.title,
      required this.theNumberOfX});

  final Icon? prefixIcon;
  final String? title;
  final RxInt theNumberOfX;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        prefixIcon ?? const Icon(Icons.people),
        const SizedBox(
          width: 8,
        ),
        AppTextBody1Widget().setText(title ?? "Nothing").build(context),
        const SizedBox(
          width: 16,
        ),
        Row(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        width: 1,
                        color: AppColors.of.grayColor[10] ??
                            Colors.black), // Thay đổi border radius ở đây
                  ),
                ),
                onPressed: () {
                  theNumberOfX.value -= 1;
                  if (theNumberOfX.value < 0) {
                    theNumberOfX.value = 0;
                  }
                },
                child: const Icon(Icons.exposure_minus_1)),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppTextBody1Widget()
                      .setTextStyle(AppTextStyleExt.of.textBody1s)
                      .setText(theNumberOfX.value.toString())
                      .build(context),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        width: 1,
                        color: AppColors.of.grayColor[10] ??
                            Colors.black), // Thay đổi border radius ở đây
                  ),
                ),
                onPressed: () {
                  theNumberOfX.value += 1;
                },
                child: const Icon(Icons.plus_one)),
          ],
        )
      ],
    );
  }
}

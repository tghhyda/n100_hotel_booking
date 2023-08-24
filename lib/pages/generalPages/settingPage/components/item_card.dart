import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.onTap, required this.title});

  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: AppColors.of.grayColor[7]!.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            AppTextBody1Widget()
                .setText(title)
                .setTextOverFlow(TextOverflow.ellipsis)
                .setTextStyle(AppTextStyleExt.of.textBody1s)
                .build(context),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.of.yellowColor[6],
            )
          ],
        ),
      ),
    );
  }
}

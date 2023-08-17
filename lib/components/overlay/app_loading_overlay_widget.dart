import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';

class AppLoadingOverlayWidget {
  static TransitionBuilder init() {
    return EasyLoading.init();
  }

  static void configure(BuildContext context) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = AppThemeExt.of.majorScale(12)
      ..radius = AppThemeExt.of.majorScale(2)
      ..backgroundColor = AppColors.of.grayColor[2]
      ..indicatorColor = AppColors.of.primaryColor
      ..progressColor = AppColors.of.primaryColor[6]
      ..textColor = AppColors.of.grayColor
      ..maskColor = AppColors.of.grayColor[4]?.withOpacity(0.4)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void show({String? message}) {
    EasyLoading.show(status: message);
  }

  static void dismiss({bool animation = true}) {
    EasyLoading.dismiss(animation: animation);
  }
}

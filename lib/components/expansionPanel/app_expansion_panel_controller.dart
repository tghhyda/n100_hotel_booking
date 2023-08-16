import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
part 'app_expansion_panel_widget.dart';

class AppExpansionPanelController extends GetxController {
  Rx<bool> isExpanded = false.obs;

  AppExpansionPanelController();

  @override
  void onInit() {
    super.onInit();
    isExpanded.value = false;
  }

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}
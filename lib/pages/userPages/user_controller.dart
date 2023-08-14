import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Rx<DateTimeRange> selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  final TextEditingController selectedDatesController = TextEditingController();
  final TextEditingController roomBookingController = TextEditingController();
  RxInt? theNumberOfRooms = 0.obs;
  RxInt? theNumberOfAdult = 0.obs;
  RxInt? theNumberOfChildren = 0.obs;

  @override
  void onInit() {
    super.onInit();

  }
}

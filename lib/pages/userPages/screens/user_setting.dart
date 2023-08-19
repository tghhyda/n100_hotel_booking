import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';

class UserSetting extends GetView<UserController>{
   UserSetting({super.key});

  @override
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.redAccent,);
  }

}

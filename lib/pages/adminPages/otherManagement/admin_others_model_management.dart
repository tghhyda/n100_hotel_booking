import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/otherManagement/convenientManagement/convenient_management_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/otherManagement/statusRoomManagement/status_room_management_page.dart';
import 'package:n100_hotel_booking/pages/adminPages/otherManagement/typeRoomManagement/type_room_management_page.dart';
import 'package:n100_hotel_booking/pages/generalPages/settingPage/components/item_card.dart';
import 'package:n100_hotel_booking/pages/generalPages/settingPage/views/change_password_view.dart';

class AdminOthersModelManagement extends GetView<AdminController> {
  const AdminOthersModelManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ItemCard(
            title: "Convenient Management",
            onTap: () {
              Get.to(() => ConvenientManagementPage());
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ItemCard(
            title: "Type room Management",
            onTap: () {
              Get.to(() => TypeRoomManagementPage());
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ItemCard(
            title: "Status room Management",
            onTap: () {
              Get.to(() => StatusRoomManagementPage());
            },
          ),
        ],
      ),
    );
  }
}

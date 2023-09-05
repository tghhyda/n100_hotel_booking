import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/otherManagement/statusRoomManagement/status_room_management_controller.dart';

class StatusRoomManagementPage extends GetView<StatusRoomManagementController> {
  StatusRoomManagementPage({super.key});

  @override
  final controller = Get.put(StatusRoomManagementController());

  final TextEditingController addStatusRoomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Room Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addStatusRoomController,
                    decoration: const InputDecoration(
                      hintText: 'Add Status Room',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    StatusRoomModel statusRoomModel = StatusRoomModel(
                        controller.generateRandomId(),
                        addStatusRoomController.text);
                    controller.addStatusRoomToFirebase(statusRoomModel);
                    addStatusRoomController.clear();
                  },
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                final statusRoomList = controller.statusRoomList;
                return ListView.builder(
                  itemCount: statusRoomList.length,
                  itemBuilder: (context, index) {
                    final statusRoom = statusRoomList[index];
                    return ListTile(
                      title: Text(statusRoom.description),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'delete') {
                            AppDefaultDialogWidget()
                                .setAppDialogType(AppDialogType.confirm)
                                .setTitle("Confirm remove status room")
                                .setNegativeText("NO")
                                .setPositiveText("YES")
                                .setOnPositive(() {
                                  controller
                                      .deleteStatusRoom(statusRoom.idStatus);
                                })
                                .buildDialog(context)
                                .show();
                          }
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/otherManagement/typeRoomManagement/type_room_management_controller.dart';

class TypeRoomManagementPage extends GetView<TypeRoomManagementController> {
  TypeRoomManagementPage({super.key});

  @override
  final controller = Get.put(TypeRoomManagementController());

  final TextEditingController addTypeRoomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type Room Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addTypeRoomController,
                    // Tạo một TextEditingController
                    decoration: const InputDecoration(
                      hintText: 'Add Type Room',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    TypeRoomModel typeRoomModel = TypeRoomModel(
                        controller.generateRandomId(),
                        addTypeRoomController.text);
                    controller.addTypeRoomToFirebase(typeRoomModel);
                    addTypeRoomController.clear();
                  },
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                final typeRoomList = controller.typeRoomList;
                return ListView.builder(
                  itemCount: typeRoomList.length,
                  itemBuilder: (context, index) {
                    final typeRoom = typeRoomList[index];
                    return ListTile(
                      title: Text(typeRoom.nameTypeRoom!),
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
                                .setTitle("Confirm remove type room")
                                .setNegativeText("NO")
                                .setPositiveText("YES")
                                .setOnPositive(() {
                              // Xử lý xóa Loại Phòng khỏi danh sách
                              controller.deleteTypeRoom(typeRoom.idTypeRoom!);
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

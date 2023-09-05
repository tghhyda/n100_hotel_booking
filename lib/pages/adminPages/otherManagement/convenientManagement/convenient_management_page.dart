import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/otherManagement/convenientManagement/convenient_management_controller.dart';

class ConvenientManagementPage extends GetView<ConvenientManagementController> {
  ConvenientManagementPage({super.key});

  @override
  final controller = Get.put(ConvenientManagementController());

  final TextEditingController addConvenientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convenient Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addConvenientController,
                    // Tạo một TextEditingController
                    decoration: const InputDecoration(
                      hintText: 'Add Convenient',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ConvenientModel convenientModel = ConvenientModel(
                        controller.generateRandomId(),
                        addConvenientController.text);
                    controller.addConvenientToFirebase(convenientModel);
                    addConvenientController.clear();
                  },
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                final convenientList = controller.convenientList;
                return ListView.builder(
                  itemCount: convenientList.length,
                  itemBuilder: (context, index) {
                    final convenient = convenientList[index];
                    return ListTile(
                      title: Text(convenient.nameConvenient),
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
                                .setTitle("Confirm delete convenient")
                                .setNegativeText("NO")
                                .setPositiveText("YES")
                                .setOnPositive(() {
                                  // Xử lý xóa Convenient khỏi danh sách
                                  controller.deleteConvenientIfNotUsed(
                                      convenient.idConvenient);
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

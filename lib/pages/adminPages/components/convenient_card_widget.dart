import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/admin_controller.dart';

class ConvenientCardWidget extends GetView<AdminController> {
  ConvenientCardWidget({
    super.key,
    required this.selectedConvenientList,
    this.onConvenientsChanged,
  });

  @override
  final controller = Get.put(AdminController());

  RxList<ConvenientModel> selectedConvenientList =
      <ConvenientModel>[].obs;
  final void Function(List<ConvenientModel> selectedConvenients)?
      onConvenientsChanged;

  Future<List<ConvenientModel>> fetchConvenientList() async {
    List<ConvenientModel> convenientList =
        await controller.fetchConvenientList();
    return convenientList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.of.grayColor[2],
        border: Border.all(
          width: 1,
          color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: FutureBuilder<List<ConvenientModel>>(
        future: fetchConvenientList(), // Future<List<TypeRoomModel>>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Hoặc một phần giao diện khác để hiển thị khi đang tải
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 8.0,
              // Khoảng cách giữa các tiện ích
              children: snapshot.data!.map((convenient) {
                return Obx(
                    ()=> InputChip(
                    label: Text(convenient.nameConvenient),
                    // Thay thế bằng dữ liệu thực tế
                    selected: selectedConvenientList.contains(convenient),
                    selectedColor: AppColors.of.yellowColor[5],
                    onSelected: (isSelected) {
                      if (isSelected) {
                        selectedConvenientList?.add(convenient);

                      } else {
                        selectedConvenientList?.remove(convenient);
                      }
                      onConvenientsChanged?.call(selectedConvenientList ?? []);
                    },
                  ),
                );
              }).toList(),
            );
          } else {
            return const Text('No data available.');
          }
        },
      ),
    );
  }
}

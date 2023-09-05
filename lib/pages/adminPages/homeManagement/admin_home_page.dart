import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/components/booking_list_widget.dart';
import 'package:n100_hotel_booking/pages/adminPages/homeManagement/admin_home_controller.dart';

class AdminHomePage extends GetView<AdminHomeController> {
  AdminHomePage({super.key});

  @override
  final controller = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextBody1Widget()
                    .setText("REVENUE STATISTICS")
                    .setTextStyle(AppTextStyleExt.of.textBody1s)
                    .setColor(AppColors.of.yellowColor[6])
                    .build(context),
                const SizedBox(
                  height: 12,
                ),
                AppTextFormFieldWidget()
                    .setController(controller.selectedDatesController!)
                    .setPrefixIcon(const Icon(Icons.date_range))
                    .setHintText(
                        "Select date time range to view revenue statistics")
                    .setIsReadOnly(true)
                    .setOnTap(() async {
                  final DateTimeRange? dateTimeRange =
                      await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(3000));
                  if (dateTimeRange != null) {
                    controller.selectedDates.value = dateTimeRange;
                    final DateFormat formatter = DateFormat('dd/MM/yyyy');
                    final String startDate =
                        formatter.format(controller.selectedDates.value.start);
                    final String endDate =
                        formatter.format(controller.selectedDates.value.end);
                    controller.selectedDatesController.text =
                        "$startDate - $endDate";
                  }
                }).build(context),
                //display list booking here
                Obx(
                  () => SizedBox(
                    height: 300,
                    child: FutureBuilder<List<BookingModel>>(
                      future: controller.searchBooking(
                          controller.selectedDates.value.start,
                          controller.selectedDates.value.end),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Hiển thị một tiêu đề hoặc tiêu đề tải dữ liệu khi đang đợi Future hoàn thành.
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // Xử lý lỗi nếu có.
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return const Text(
                              'No Booking in this period of time');
                        } else {
                          List<BookingModel> bookings = snapshot.data ?? [];
                          return ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              // Hiển thị thông tin của từng booking ở đây
                              return ListTile(
                                title: Text(
                                    "Booking ID: ${bookings[index].bookingId ?? 'N/A'}"),
                                // Thêm các thông tin khác của booking tương tự ở đây
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

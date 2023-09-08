import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/config/app_theme.dart';
import 'package:n100_hotel_booking/constants/app_colors_ext.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/adminPages/components/booking_list_widget.dart';
import 'package:n100_hotel_booking/pages/adminPages/homeManagement/admin_home_controller.dart';
import 'package:n100_hotel_booking/pages/adminPages/homeManagement/views/admin_top_3_room.dart';
import 'package:n100_hotel_booking/pages/adminPages/homeManagement/views/admin_top_3_user.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/booking_management_detail_page.dart';

class AdminHomePage extends GetView<AdminHomeController> {
  AdminHomePage({super.key});

  @override
  final controller = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorsExt.backgroundColor,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
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
                          "Showing this month's renvenues, tap to select a time")
                      .setIsReadOnly(true)
                      .setOnTap(() async {
                    final DateTime now = DateTime.now();
                    final DateTime firstDayOfMonth =
                        DateTime(now.year, now.month, 1);
                    final DateTime lastDayOfMonth = DateTime(
                        firstDayOfMonth.year, firstDayOfMonth.month + 1, 0);
                    final DateTimeRange initialDateRange = DateTimeRange(
                        start: firstDayOfMonth, end: lastDayOfMonth);

                    final DateTimeRange? dateTimeRange =
                        await showDateRangePicker(
                            context: context,
                            initialDateRange: initialDateRange,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(3000));
                    if (dateTimeRange != null) {
                      controller.selectedDates.value = dateTimeRange;
                      final DateFormat formatter = DateFormat('dd/MM/yyyy');
                      final String startDate = formatter
                          .format(controller.selectedDates.value.start);
                      final String endDate =
                          formatter.format(controller.selectedDates.value.end);
                      controller.selectedDatesController.text =
                          "$startDate - $endDate";
                    }
                  }).build(context),
                  //display list booking here
                  Obx(
                    () => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: FutureBuilder<List<BookingModel?>>(
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
                            List<BookingModel?> bookings = snapshot.data ?? [];
                            return Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: AppColors.of.lightBlueColor[6],
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: AppTextBody1Widget()
                                        .setText(
                                            "TOTAL REVENUE: ${controller.formatPrice(controller.calculateTotalRevenue(bookings).toInt())} VND")
                                        .setTextStyle(
                                            AppTextStyleExt.of.textBody1s)
                                        .setMaxLines(2)
                                        .setTextOverFlow(TextOverflow.ellipsis)
                                        .setColor(AppColors.of.yellowColor[3])
                                        .build(context),
                                  ),
                                ),
                                AppTextBody1Widget()
                                    .setText("LIST BOOKING")
                                    .setColor(AppColors.of.lightBlueColor[6])
                                    .build(context),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: bookings.length,
                                    itemBuilder: (context, index) {
                                      // Hiển thị thông tin của từng booking ở đây
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                              () =>
                                                  BookingManagementDetailPage(),
                                              arguments: bookings[index]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors
                                                      .of.lightBlueColor),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          margin: const EdgeInsets.only(top: 8),
                                          child: Column(
                                            children: [
                                              Wrap(
                                                spacing: 25,
                                                children: [
                                                  AppTextBody1Widget()
                                                      .setText(
                                                          "Booking ID: ${bookings[index]?.bookingId ?? 'N/A'}")
                                                      .setColor(AppColors
                                                          .of.greenColor[6])
                                                      .setMaxLines(2)
                                                      .setTextOverFlow(
                                                          TextOverflow.ellipsis)
                                                      .build(context),
                                                  const Spacer(),
                                                  AppTextBody1Widget()
                                                      .setText(
                                                          "+ ${controller.formatPrice(bookings[index]!.totalPrice!.toInt())} VND")
                                                      .setColor(AppColors
                                                          .of.redColor[6])
                                                      .build(context)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.4, // Đặt chiều cao tùy ý
              child: PageView(
                controller: PageController(initialPage: 0),
                children: [
                  // Widget hiển thị top 3 phòng
                  AdminTop3Room(),
                  AdminTop3User()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

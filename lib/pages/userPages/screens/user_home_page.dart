import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:n100_hotel_booking/components/text/app_text_base_builder.dart';
import 'package:n100_hotel_booking/components/textFormField/app_text_form_field_base_builder.dart';
import 'package:n100_hotel_booking/pages/userPages/screens/views/search_room_detail.dart';
import 'package:n100_hotel_booking/pages/userPages/user_controller.dart';

class UserHomePage extends GetView<UserController> {
  UserHomePage({super.key});

  @override
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFormFieldWidget()
              .setController(controller.selectedDatesController!)
              .setPrefixIcon(const Icon(Icons.date_range))
              .setHintText("Select check-in and check-out date")
              .setIsReadOnly(true)
              .setOnTap(() async {
            final DateTimeRange? dateTimeRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000));
            if (dateTimeRange != null) {
              controller.selectedDates?.value = dateTimeRange;
              final DateFormat formatter = DateFormat('dd/MM/yyyy');
              final String startDate =
                  formatter.format(controller.selectedDates!.value.start);
              final String endDate =
                  formatter.format(controller.selectedDates!.value.end);
              controller.selectedDatesController?.text =
                  "$startDate - $endDate";
            }
          }).build(context),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () => AppTextBody1Widget()
                .setText(
                    "${controller.selectedDates.value.duration.inDays} night(s) stay")
                .build(context),
          ),
          const SizedBox(
            height: 8,
          ),
          AppTextFormFieldWidget()
              .setController(controller.roomBookingController)
              .setPrefixIcon(const Icon(Icons.family_restroom))
              .setHintText("Room, Adult, Children")
              .setIsReadOnly(true)
              .setOnTap(() async {
            final result = await Get.to(() => SearchRoomDetail());
            if (result != null) {
              final roomCount = result['room'];
              final adultCount = result['theNumberOfAdult'];
              final childrenCount = result['children'];

              controller.roomBookingController.text =
                  'Room: $roomCount, Adult: $adultCount, Children: $childrenCount';
            }
          }).build(context)
        ],
      ),
    );
  }
}

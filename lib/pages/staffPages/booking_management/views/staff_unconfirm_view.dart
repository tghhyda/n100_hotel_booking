import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/booking_management_controller.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/booking_management_detail_page.dart';
import 'package:n100_hotel_booking/pages/staffPages/components/staff_booking_card_widget.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/components/booking_card_widget.dart';

class StaffUnConfirmView extends GetView<BookingManagementController> {
  StaffUnConfirmView({super.key});

  @override
  final controller = Get.put(BookingManagementController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchUnconfirmedBookings();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<BookingModel>>(
          future: controller.fetchUnconfirmedBookings(),
          // Hàm này cần được định nghĩa trong HistoryController
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No unconfirmed bookings.'));
            } else {
              List<BookingModel> unconfirmedBookings = snapshot.data!;
              return ListView.builder(
                itemCount: unconfirmedBookings.length,
                itemBuilder: (context, index) {
                  BookingModel booking = unconfirmedBookings[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StaffBookingCardWidget(
                      bookingModel: booking,
                      onPressed: () {
                        Get.to(() => BookingManagementDetailPage(),
                            arguments: booking);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

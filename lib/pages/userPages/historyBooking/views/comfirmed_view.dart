import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/components/booking_card_widget.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/history_controller.dart';

class ConfirmedView extends GetView<HistoryController>{
  ConfirmedView({super.key});

  @override
  final controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookingModel>>(
      future: controller.fetchConfirmedBookings(), // Hàm này cần được định nghĩa trong HistoryController
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
                child: BookingCardWidget(
                  bookingModel: booking,
                  onPressed: () {},
                ),
              );
            },
          );
        }
      },
    );
  }
}
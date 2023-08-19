import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/history_controller.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/views/cancel_view.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/views/checked_in_view.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/views/comfirmed_view.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/views/payment_completed_view.dart';
import 'package:n100_hotel_booking/pages/userPages/historyBooking/views/un_confirm_view.dart';

class HistoryPage extends GetView<HistoryController> {
  HistoryPage({super.key});

  @override
  final controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "UnConfirmed"),
              Tab(text: "Confirmed",),
              Tab(text: "Checked-In"),
              Tab(text: "Payment completed"),
              Tab(text: "Canceled request",)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UnConfirmView(),
            ConfirmedView(),
            CheckedInView(),
            PaymentCompletedView(),
            CanceledView()
          ],
        ),
      ),
    );
  }
}

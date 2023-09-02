import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/views/staff_cancel_request_view.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/views/staff_checked_in_view.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/views/staff_checked_out_view.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/views/staff_confirm_view.dart';
import 'package:n100_hotel_booking/pages/staffPages/booking_management/views/staff_unconfirm_view.dart';
import 'booking_management_controller.dart';

class BookingManagementPage extends GetView<BookingManagementController> {
  const BookingManagementPage({super.key});

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
              Tab(
                text: "Confirmed",
              ),
              Tab(text: "Checked-In"),
              Tab(text: "Payment completed"),
              Tab(
                text: "Canceled request",
              )
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            StaffUnConfirmView(),
            StaffConfirmView(),
            StaffCheckedInView(),
            StaffCheckedOutView(),
            StaffCancelRequestView()
          ],
        ),
      ),
    );
  }
}

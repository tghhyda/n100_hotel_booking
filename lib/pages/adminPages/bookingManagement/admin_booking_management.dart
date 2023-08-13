import 'package:flutter/material.dart';

class AdminBookingManagement extends StatefulWidget {
  const AdminBookingManagement({Key? key}) : super(key: key);

  @override
  State<AdminBookingManagement> createState() => _AdminBookingManagementState();
}

class _AdminBookingManagementState extends State<AdminBookingManagement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Booking'),
      ),
    );
  }
}

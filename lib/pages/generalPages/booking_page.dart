import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class BookingPage extends StatefulWidget {
  final UserModel currentUser;
  final RoomModel selectedRoom;

  const BookingPage({
    Key? key,
    required this.currentUser,
    required this.selectedRoom,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  int _numberOfPeople = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Booking Information:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Check-in date: ${_startDate ?? 'Not selected yet'}'),
            ElevatedButton(
              onPressed: () => _selectStartDate(context),
              child: const Text('Select Check-in date'),
            ),
            const SizedBox(height: 16),
            Text('Check-out date: ${_endDate ?? 'Not seletected yet'}'),
            ElevatedButton(
              onPressed: () => _selectEndDate(context),
              child: const Text('Select check-out date'),
            ),
            const SizedBox(height: 16),
            Text('The number of people: $_numberOfPeople'),
            Slider(
              value: _numberOfPeople.toDouble(),
              min: 1,
              max: widget.selectedRoom.capacity.toDouble(),
              onChanged: (value) {
                setState(() {
                  _numberOfPeople = value.toInt();
                });
              },
              divisions: 3,
              label: _numberOfPeople.toString(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Thực hiện đặt phòng và chuyển sang trang thành công
                postBookingInformation(
                    context: context,
                    userId: widget.currentUser.email,
                    roomId: widget.selectedRoom.idRoom,
                    startDate: _startDate!,
                    endDate: _endDate!,
                    numberOfPeople: _numberOfPeople,
                    isCheckIn: false,
                    isCheckOut: false,
                    isPayment: false);
              },
              child: const Text('Đặt phòng'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  static Future<void> postBookingInformation({
    required BuildContext context,
    required String userId, // Current user ID
    required String roomId, // Selected room ID
    required DateTime startDate,
    required DateTime endDate,
    required int numberOfPeople,
    required bool isCheckIn,
    required bool isCheckOut,
    required bool isPayment,
  }) async {
    try {
      CollectionReference bookingsCollection =
          FirebaseFirestore.instance.collection('bookings');
      DocumentReference newBookingRef = bookingsCollection.doc();
      await bookingsCollection.add({
        'bookingId': newBookingRef.id,
        'userId': userId,
        'roomId': roomId,
        'startDate': startDate.toUtc(),
        'endDate': endDate.toUtc(),
        'numberOfPeople': numberOfPeople,
        'isCheckIn': isCheckIn,
        'isCheckOut': isCheckOut,
        'isPayment': isPayment,
        'createdAt': FieldValue.serverTimestamp(),
        // Use serverTimestamp to store the current server time
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Booking success')));
      Navigator.pop(context);
      print('Booking information posted successfully!');
    } catch (e) {
      print('Error posting booking information: $e');
      // Handle any errors that might occur during the data posting process.
    }
  }
}

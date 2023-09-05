import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class AdminHomeController extends GetxController {
  final Rx<DateTimeRange> selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  final TextEditingController selectedDatesController = TextEditingController();

  Timestamp dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  Future<List<BookingModel>> searchBooking(
      DateTime startDate, DateTime endDate) async {
    // Chuyển đổi DateTime thành Timestamp
    final Timestamp startTimestamp = dateTimeToTimestamp(startDate);
    final Timestamp endTimestamp = dateTimeToTimestamp(endDate);

    // Kết nối với Firestore
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Truy vấn BookingModel từ Firestore sử dụng Timestamp
      final QuerySnapshot querySnapshot = await firestore
          .collection('bookings')
          .where('createAt', isGreaterThanOrEqualTo: startTimestamp)
          .where('createAt', isLessThanOrEqualTo: endTimestamp)
          .get();

      print('${querySnapshot.size}');

      // Chuyển đổi dữ liệu từ Firestore thành danh sách BookingModel
      final List<BookingModel> bookings = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return BookingModel.fromJson(data);
      }).toList();

      return bookings;
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi khi tìm kiếm Booking: $e');
      rethrow;
    }
  }
}

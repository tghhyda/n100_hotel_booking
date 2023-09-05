import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class BookingListWidget extends StatelessWidget {
  final Future<List<BookingModel>> futureBookings;

  const BookingListWidget({Key? key, required this.futureBookings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FutureBuilder<List<BookingModel>>(
        future: futureBookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Hiển thị một tiêu đề hoặc tiêu đề tải dữ liệu khi đang đợi Future hoàn thành.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Xử lý lỗi nếu có.
            return Text('Error: ${snapshot.error}');
          } else {
            // Hiển thị danh sách booking khi Future hoàn thành.
            List<BookingModel> bookings = snapshot.data ?? [];
            if(bookings.length > 0){
              print("có gia trịiiiiiiiiiiiiiiiiiiiiii");
            }
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                // Hiển thị thông tin của từng booking ở đây
                return ListTile(
                  title:
                      Text("Booking ID: ${bookings[index].bookingId ?? 'N/A'}"),
                  // Thêm các thông tin khác của booking tương tự ở đây
                );
              },
            );
          }
        },
      ),
    );
  }
}

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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<BookingModel?>> searchBooking(
      DateTime startDate, DateTime endDate) async {
    try {
      // Truy vấn BookingModel từ Firestore
      final QuerySnapshot querySnapshot =
          await firestore.collection('bookings').get();

      // Lọc danh sách BookingModel dựa trên DateTime
      final List<BookingModel?> bookings = querySnapshot.docs
          .map((doc) {
            final Map<String, dynamic> data =
                doc.data() as Map<String, dynamic>;
            String createAtString =
                data['createAt']; // Lấy dữ liệu dưới dạng chuỗi

            // Chuyển đổi chuỗi thành DateTime
            DateTime createAtDateTime = DateTime.parse(createAtString);

            // Kiểm tra xem createAtDateTime có nằm trong khoảng startDate và endDate không
            if (createAtDateTime.isAfter(startDate) &&
                createAtDateTime.isBefore(endDate)) {
              return BookingModel.fromJson(data);
            } else {
              return null;
            }
          })
          .where((booking) => booking != null)
          .toList();

      return bookings;
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi khi tìm kiếm Booking: $e');
      rethrow;
    }
  }

  double calculateTotalRevenue(List<BookingModel?> bookings) {
    double totalRevenue = 0;
    for (var booking in bookings) {
      if (booking != null) {
        totalRevenue += booking.totalPrice ?? 0;
      }
    }
    return totalRevenue;
  }

  String formatPrice(int price) {
    String priceString = price.toString();
    List<String> chunks = [];
    for (int i = priceString.length - 1; i >= 0; i -= 3) {
      int start = i - 2 >= 0 ? i - 2 : 0;
      chunks.insert(0, priceString.substring(start, i + 1));
    }

    String formattedPrice = chunks.join('.');

    return formattedPrice;
  }

  Future<List<RoomModel>> findTop3Rooms() async {
    try {
      final QuerySnapshot bookingQuery =
          await FirebaseFirestore.instance.collection('bookings').get();

      final Map<String, int> roomBookingCounts = {};

      for (final doc in bookingQuery.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final room = data['room'] as String?;

        if (room != null) {
          if (roomBookingCounts.containsKey(room)) {
            roomBookingCounts[room] = roomBookingCounts[room]! + 1;
          } else {
            roomBookingCounts[room] = 1;
          }
        }
      }
      final sortedRooms = roomBookingCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final top3Rooms = sortedRooms.take(3);
      final List<RoomModel> topRoomsData = [];

      for (final roomEntry in top3Rooms) {
        final roomId = roomEntry.key;
        final roomDoc = await FirebaseFirestore.instance
            .collection('rooms')
            .doc(roomId)
            .get();

        if (roomDoc.exists) {
          final roomData = roomDoc.data() as Map<String, dynamic>;
          final roomModel = RoomModel.fromJson(roomData);
          topRoomsData.add(roomModel);
        }
      }

      return topRoomsData;
    } catch (e) {
      print('Lỗi khi tìm top 3 phòng: $e');
      return [];
    }
  }

  Future<List<UserModel>> findTop3Users() async {
    try {
      final QuerySnapshot querySnapshot =
          await firestore.collection('bookings').get();

      final Map<String, int> userBookingCount = {};

      // Đếm số lần đặt của mỗi người dùng
      for (var doc in querySnapshot.docs) {
        final userData = doc.data();
        if (userData != null && userData is Map<String, dynamic>) {
          final userId = userData['user'];
          if (userId != null && userId is String) {
            if (userBookingCount.containsKey(userId)) {
              userBookingCount[userId] = userBookingCount[userId]! + 1;
            } else {
              userBookingCount[userId] = 1;
            }
          }
        }
      }

      // Sắp xếp theo số lần đặt giảm dần
      final sortedUserIds = userBookingCount.keys.toList()
        ..sort((a, b) => userBookingCount[b]!.compareTo(userBookingCount[a]!));

      // Lấy danh sách người dùng theo thứ tự giảm dần
      final List<UserModel> topUsers = [];
      for (int i = 0; i < 3 && i < sortedUserIds.length; i++) {
        final userId = sortedUserIds[i];
        final user = await getUserInfoByEmail(userId);
        topUsers.add(user);
      }

      return topUsers;
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi khi tìm kiếm top người dùng: $e');
      throw e;
    }
  }

  Future<UserModel> getUserInfoByEmail(String email) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception('User not found');
    }
  }
}

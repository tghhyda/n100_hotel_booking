import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class BookingManagementController extends GetxController {

  Future<List<BookingModel>> getAllBookings() async {
    List<BookingModel> bookings = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('bookings').get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        BookingModel booking = BookingModel.fromJson(data);
        bookings.add(booking);
      }

      return bookings;
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Lỗi khi lấy dữ liệu đặt phòng từ Firebase: $e");
      return [];
    }
  }

  Future<List<BookingModel>> fetchCancelBookings() async {
    List<BookingModel> allBookings = await getAllBookings();
    return allBookings
        .where((booking) => booking.isCancelBooking == true)
        .toList();
  }

  Future<List<BookingModel>> fetchUnconfirmedBookings() async {
    List<BookingModel> allBookings = await getAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == false && booking.isCancelBooking == false)
        .toList();
  }

  Future<List<BookingModel>> fetchConfirmedBookings() async {
    List<BookingModel> allBookings = await getAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == true &&
            booking.isCheckIn == false &&
            booking.isCancelBooking == false)
        .toList();
  }

  Future<List<BookingModel>> fetchNotCheckedInBookings() async {
    List<BookingModel> allBookings = await getAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == true &&
            booking.isCancelBooking == false &&
            booking.isCheckIn == false)
        .toList();
  }

// Lấy danh sách các booking có isCheckIn bằng true
  Future<List<BookingModel>> fetchCheckedInBookings() async {
    List<BookingModel> allBookings = await getAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == true &&
            booking.isCheckIn == true &&
            booking.isCancelBooking == false &&
            booking.isPaid == false)
        .toList();
  }

// Lấy danh sách các booking có isPaid bằng true
  Future<List<BookingModel>> fetchPaidBookings() async {
    List<BookingModel> allBookings = await getAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == true &&
            booking.isCancelBooking == false &&
            booking.isPaid == true)
        .toList();
  }

  Future<UserModel> getCurrentUserInfoByEmail(String email) async {
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

  Future<RoomModel> getRoomById(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('rooms').doc(id).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      RoomModel roomModel = RoomModel.fromJson(data);
      return roomModel;
    } else {
      throw Exception('Room not found');
    }
  }
}

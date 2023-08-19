import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/models/base_model.dart';

class HistoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? currentUser;
  RoomModel? roomModel;

  @override
  void onInit() async {
    super.onInit();
    currentUser = await getCurrentUserInfoByEmail(
        FirebaseAuth.instance.currentUser!.email!);
  }

  Future<void> updateBookingIsCancelStatusByUserAndRoom(
      String email, String roomId, bool newIsCancelStatus) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('user', isEqualTo: email)
          .where('room', isEqualTo: roomId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String bookingId = snapshot.docs[0].id; // Lấy ID của tài liệu booking
        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(bookingId)
            .update({'isCancelBooking': newIsCancelStatus});
        print('Booking cancellation status updated successfully');
      } else {
        print('No booking found for the specified user and room');
      }
    } catch (error) {
      print('Error updating booking cancellation status: $error');
    }
  }

  Future<List<BookingModel>> fetchAllBookings() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      CollectionReference bookingsCollection =
          FirebaseFirestore.instance.collection('bookings');
      QuerySnapshot snapshot = await bookingsCollection
          .where('user', isEqualTo: currentUser.email)
          .get();

      return snapshot.docs
          .map((doc) =>
              BookingModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } else {
      return []; // Trả về danh sách rỗng nếu không có người dùng đăng nhập
    }
  }

  Future<List<BookingModel>> fetchCancelBookings() async {
    List<BookingModel> allBookings = await fetchAllBookings();
    return allBookings
        .where((booking) => booking.isCancelBooking == true)
        .toList();
  }

  Future<List<BookingModel>> fetchUnconfirmedBookings() async {
    List<BookingModel> allBookings = await fetchAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == false && booking.isCancelBooking == false)
        .toList();
  }

  Future<List<BookingModel>> fetchConfirmedBookings() async {
    List<BookingModel> allBookings = await fetchAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == true &&
            booking.isCheckIn == false &&
            booking.isCancelBooking == false)
        .toList();
  }

  Future<List<BookingModel>> fetchNotCheckedInBookings() async {
    List<BookingModel> allBookings = await fetchAllBookings();
    return allBookings
        .where((booking) =>
            booking.isConfirm == true &&
            booking.isCancelBooking == false &&
            booking.isCheckIn == false)
        .toList();
  }

// Lấy danh sách các booking có isCheckIn bằng true
  Future<List<BookingModel>> fetchCheckedInBookings() async {
    List<BookingModel> allBookings = await fetchAllBookings();
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
    List<BookingModel> allBookings = await fetchAllBookings();
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

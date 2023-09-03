import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:n100_hotel_booking/components/dialog/app_dialog_base_builder.dart';
import 'package:n100_hotel_booking/components/snackBar/app_snack_bar_base_builder.dart';
import 'package:n100_hotel_booking/models/base_model.dart';
import 'package:n100_hotel_booking/pages/staffPages/staff_home_page.dart';

class BookingManagementController extends GetxController {
  Future<void> updateBookingIsConfirm(String bookingId, bool isConfirm) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final bookingsCollection = firestore.collection('bookings');

      // Tìm booking dựa trên bookingId
      QuerySnapshot bookingSnapshot = await bookingsCollection
          .where('bookingId', isEqualTo: bookingId)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        DocumentSnapshot bookingDoc = bookingSnapshot.docs.first;
        await bookingDoc.reference.update({'isConfirm': isConfirm});

        print('Cập nhật thành công!');
        AppSnackBarWidget()
            .setContent(const Text("Change status to confirm success"))
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.toastMessage)
            .showSnackBar(Get.context!);
        Get.offAll(() => StaffHomePage());
      } else {
        print('Không tìm thấy booking với bookingId: $bookingId');
        // Xử lý trường hợp không tìm thấy booking với bookingId cụ thể ở đây
      }
    } catch (error) {
      print('Lỗi khi cập nhật: $error');
      AppDefaultDialogWidget()
          .setIsHaveCloseIcon(true)
          .setAppDialogType(AppDialogType.error)
          .setTitle("Something went wrong")
          .buildDialog(Get.context!)
          .show();
      throw error;
    }
  }

  Future<void> updateBookingIsCheckin(String bookingId, bool isCheckIn) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final bookingsCollection = firestore.collection('bookings');

      // Tìm booking dựa trên bookingId
      QuerySnapshot bookingSnapshot = await bookingsCollection
          .where('bookingId', isEqualTo: bookingId)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        DocumentSnapshot bookingDoc = bookingSnapshot.docs.first;
        await bookingDoc.reference.update({'isCheckIn': isCheckIn});

        print('Cập nhật thành công!');
        AppSnackBarWidget()
            .setContent(const Text("Change status to confirm success"))
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.toastMessage)
            .showSnackBar(Get.context!);
        Get.offAll(() => StaffHomePage());
      } else {
        print('Không tìm thấy booking với bookingId: $bookingId');
        // Xử lý trường hợp không tìm thấy booking với bookingId cụ thể ở đây
      }
    } catch (error) {
      print('Lỗi khi cập nhật: $error');
      AppDefaultDialogWidget()
          .setIsHaveCloseIcon(true)
          .setAppDialogType(AppDialogType.error)
          .setTitle("Something went wrong")
          .buildDialog(Get.context!)
          .show();
      throw error;
    }
  }

  Future<void> updateBookingIsPaid(String bookingId, bool isPaid) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final bookingsCollection = firestore.collection('bookings');

      // Tìm booking dựa trên bookingId
      QuerySnapshot bookingSnapshot = await bookingsCollection
          .where('bookingId', isEqualTo: bookingId)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        DocumentSnapshot bookingDoc = bookingSnapshot.docs.first;
        await bookingDoc.reference
            .update({'isPaid': isPaid, 'isCheckOut': isPaid});

        print('Cập nhật thành công!');
        AppSnackBarWidget()
            .setContent(const Text("Change status to confirm success"))
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.toastMessage)
            .showSnackBar(Get.context!);
        Get.offAll(() => StaffHomePage());
      } else {
        print('Không tìm thấy booking với bookingId: $bookingId');
        // Xử lý trường hợp không tìm thấy booking với bookingId cụ thể ở đây
      }
    } catch (error) {
      print('Lỗi khi cập nhật: $error');
      AppDefaultDialogWidget()
          .setIsHaveCloseIcon(true)
          .setAppDialogType(AppDialogType.error)
          .setTitle("Something went wrong")
          .buildDialog(Get.context!)
          .show();
      throw error;
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final bookingsCollection = firestore.collection('bookings');

      QuerySnapshot bookingSnapshot = await bookingsCollection
          .where('bookingId', isEqualTo: bookingId)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot bookingDoc = bookingSnapshot.docs.first;

        // Xóa booking
        await bookingDoc.reference.delete();

        print('Xóa booking thành công!');
        AppSnackBarWidget()
            .setContent(const Text("Delete Booking success"))
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.toastMessage)
            .showSnackBar(Get.context!);
        Get.offAll(() => StaffHomePage());
      } else {
        print('Không tìm thấy booking với bookingId: $bookingId');
      }
    } catch (error) {
      print('Lỗi khi xóa booking: $error');
      AppDefaultDialogWidget()
          .setIsHaveCloseIcon(true)
          .setAppDialogType(AppDialogType.error)
          .setTitle("Something went wrong")
          .buildDialog(Get.context!)
          .show();
    }
  }

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
}

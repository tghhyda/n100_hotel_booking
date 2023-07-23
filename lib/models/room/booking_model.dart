import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/user_model.dart';

class BookingModel {
  final UserModel? user;
  final RoomModel? room;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? numberOfPeople;
  bool? isCheckIn;
  bool? isCheckOut;
  bool? isPayment;

  BookingModel(
      this.user, this.room, this.startDate, this.endDate, this.numberOfPeople,
      {required bool isCheckIn,
      required bool isCheckOut,
      required bool isPayment});
}

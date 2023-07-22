import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/user_model.dart';

class BookingModel {
  final UserModel? user;
  final RoomModel? room;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? numberOfPeople;
  final bool? isCheckIn;
  final bool? isCheckOut;
  final bool? isPayment;

  BookingModel(this.user, this.room, this.startDate, this.endDate,
      this.numberOfPeople, this.isCheckIn, this.isCheckOut, this.isPayment);
}

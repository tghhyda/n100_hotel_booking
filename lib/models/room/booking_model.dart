part of '../base_model.dart';

@JsonSerializable()
class BookingModel {
  final UserModel? user;
  final RoomModel? room;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? numberOfRooms;
  final int? numberOfAdult;
  final int? numberOfChildren;
  bool? isCheckIn;
  bool? isCheckOut;
  bool? isPayment;


  BookingModel(
      this.user,
      this.room,
      this.startDate,
      this.endDate,
      this.numberOfRooms,
      this.numberOfAdult,
      this.numberOfChildren,
      this.isCheckIn,
      this.isCheckOut,
      this.isPayment);

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}

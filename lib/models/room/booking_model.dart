part of '../base_model.dart';

@JsonSerializable()
class BookingModel {
  final String? user;
  final String? room;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? numberOfRooms;
  final int? numberOfAdult;
  final int? numberOfChildren;
  String? promoCode;
  List<ServiceModel?>? services;
  double? totalPrice;
  bool? isCancelBooking;
  bool? isConfirm;
  bool? isCheckIn;
  bool? isCheckOut;
  bool? isPaid;


  BookingModel(
      this.user,
      this.room,
      this.startDate,
      this.endDate,
      this.numberOfRooms,
      this.numberOfAdult,
      this.numberOfChildren,
      this.promoCode,
      this.services,
      this.totalPrice,
      this.isCancelBooking,
      this.isConfirm,
      this.isCheckIn,
      this.isCheckOut,
      this.isPaid);

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}

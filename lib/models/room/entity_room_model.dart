part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class EntityRoomModel {
  final String id;
  String name;
  BookingModel? currentBooking;


  EntityRoomModel(this.id, this.name, this.currentBooking);

  factory EntityRoomModel.fromJson(Map<String, dynamic> json) =>
      _$EntityRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntityRoomModelToJson(this);

}

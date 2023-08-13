
part of '../base_model.dart';

@JsonSerializable()
class RoomModel {
  final String idRoom;
  final TypeRoomModel typeRoom;
  final int priceRoom;
  final int capacity;
  final StatusRoomModel statusRoom;
  final List<ConvenientModel?>? convenient;
  final List<ReviewModel?>? review;
  final List<String?>? images;
  final String description;

  RoomModel(this.typeRoom, this.priceRoom, this.capacity, this.statusRoom,
      this.convenient, this.review, this.description, this.images,
      {required this.idRoom});

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}

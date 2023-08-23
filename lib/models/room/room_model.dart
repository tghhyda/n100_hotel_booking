
part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class RoomModel {
  final String idRoom;
  final TypeRoomModel typeRoom;
  final int priceRoom;
  final int capacity;
  final int area;
  final int beds;
  late final int quantity;
  final StatusRoomModel statusRoom;
  final List<ConvenientModel?>? convenient;
  final List<ReviewModel?>? review;
  final List<String?>? images;
  final String description;


  RoomModel(
      this.idRoom,
      this.typeRoom,
      this.priceRoom,
      this.capacity,
      this.area,
      this.beds,
      this.quantity,
      this.statusRoom,
      this.convenient,
      this.review,
      this.images,
      this.description);

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}

part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class RoomModel {
  final String idRoom;
  TypeRoomModel typeRoom;
  int priceRoom;
  int capacity;
  int area;
  int beds;
  int quantity;
  StatusRoomModel statusRoom;
  List<ConvenientModel?>? convenient;
  List<ReviewModel?>? review;
  List<String?>? images;
  List<EntityRoomModel?>? entityRoom;
  String description;


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
      this.entityRoom,
      this.description);

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

}

import 'package:n100_hotel_booking/models/room/convenient_model.dart';
import 'package:n100_hotel_booking/models/room/review_model.dart';
import 'package:n100_hotel_booking/models/room/status_room_model.dart';
import 'package:n100_hotel_booking/models/room/type_room_model.dart';

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
}

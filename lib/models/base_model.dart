import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';
part 'user_model.dart';
part 'room/room_model.dart';
part 'room/type_room_model.dart';
part 'room/booking_model.dart';
part 'room/convenient_model.dart';
part 'room/status_room_model.dart';
part 'room/review_model.dart';

abstract class BaseModel {}
class EmptyModel extends BaseModel {}
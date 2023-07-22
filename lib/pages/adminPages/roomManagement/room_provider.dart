import 'package:flutter/material.dart';
import 'package:n100_hotel_booking/models/room/room_model.dart';

class RoomProvider with ChangeNotifier {
  RoomModel _room;

  RoomProvider(this._room);

  RoomModel get room => _room;

  void updateRoom(RoomModel updatedRoom) {
    _room = updatedRoom;
    notifyListeners();
  }
}

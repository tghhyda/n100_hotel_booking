part of '../base_model.dart';

@JsonSerializable()
class TypeRoomModel{
   final String idTypeRoom;
   final String nameTypeRoom;

  TypeRoomModel(this.idTypeRoom, this.nameTypeRoom);

  factory TypeRoomModel.fromJson(Map<String, dynamic> json) =>
      _$TypeRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypeRoomModelToJson(this);
}
part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class TypeRoomModel {
  String? idTypeRoom;
  String? nameTypeRoom;

  TypeRoomModel(this.idTypeRoom, this.nameTypeRoom);

  TypeRoomModel.noParam();

  factory TypeRoomModel.fromJson(Map<String, dynamic> json) =>
      _$TypeRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypeRoomModelToJson(this);
}

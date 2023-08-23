
part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class StatusRoomModel{
  final String idStatus;
  final String description;

  StatusRoomModel(this.idStatus, this.description);

  factory StatusRoomModel.fromJson(Map<String, dynamic> json) =>
      _$StatusRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusRoomModelToJson(this);
}
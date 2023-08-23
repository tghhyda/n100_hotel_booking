
part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class ConvenientModel{
  final String idConvenient;
  final String nameConvenient;

  ConvenientModel(this.idConvenient, this.nameConvenient);

  factory ConvenientModel.fromJson(Map<String, dynamic> json) =>
      _$ConvenientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConvenientModelToJson(this);
}
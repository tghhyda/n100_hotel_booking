part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class PromoCodeModel{
  String? idPromo;
  String? namePromo;
  DateTime? startDate;
  DateTime? endDate;
  double? discount;

  PromoCodeModel(this.idPromo, this.namePromo, this.startDate, this.endDate,
      this.discount);

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeModelToJson(this);
}
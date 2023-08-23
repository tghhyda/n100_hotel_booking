
part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class ServiceModel {
  String? idService;
  String? nameService;
  String? imageService;
  double? priceService;


  ServiceModel(
      this.idService, this.nameService, this.imageService, this.priceService);

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

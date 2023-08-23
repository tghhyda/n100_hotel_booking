part of '../base_model.dart';

@JsonSerializable()
@CopyWith()
class ReviewModel {
  final String idReview;
  final String user;
  final String room;
  final DateTime timeReview;
  final String detailReview;
  final double rate;

  ReviewModel(this.idReview, this.user, this.room, this.timeReview,
      this.detailReview, this.rate);

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

}

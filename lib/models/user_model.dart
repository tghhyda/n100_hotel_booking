part of 'base_model.dart';

@JsonSerializable()
@CopyWith()
class UserModel {
  final String nameUser;
  String? birthday;
  String? phoneNumber;
  String? imageUrl;
  final String role;
  final String email;
  String? address;
  String? gender;

  UserModel(
      {required this.nameUser,
      required this.birthday,
      required this.phoneNumber,
      required this.imageUrl,
      required this.role,
      required this.email,
      required this.address,
      required this.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

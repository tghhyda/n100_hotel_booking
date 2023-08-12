part of 'base_model.dart';

@JsonSerializable()
class UserModel {
  final String nameUser;
  final String birthday;
  final String phoneNumber;
  final String imageUrl;
  final String role;
  final String email;
  final String address;
  final String gender;

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

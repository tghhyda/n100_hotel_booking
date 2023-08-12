// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      nameUser: json['nameUser'] as String,
      birthday: json['birthday'] as String,
      phoneNumber: json['phoneNumber'] as String,
      imageUrl: json['imageUrl'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nameUser': instance.nameUser,
      'birthday': instance.birthday,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'role': instance.role,
      'email': instance.email,
      'address': instance.address,
      'gender': instance.gender,
    };

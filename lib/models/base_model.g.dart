// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      nameUser: json['nameUser'] as String,
      birthday: json['birthday'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      role: json['role'] as String,
      email: json['email'] as String,
      address: json['address'] as String?,
      gender: json['gender'] as String?,
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

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      json['idRoom'] as String,
      TypeRoomModel.fromJson(json['typeRoom'] as Map<String, dynamic>),
      json['priceRoom'] as int,
      json['capacity'] as int,
      json['area'] as int,
      json['beds'] as int,
      json['quantity'] as int,
      StatusRoomModel.fromJson(json['statusRoom'] as Map<String, dynamic>),
      (json['convenient'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ConvenientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['review'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['images'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      json['description'] as String,
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'idRoom': instance.idRoom,
      'typeRoom': instance.typeRoom,
      'priceRoom': instance.priceRoom,
      'capacity': instance.capacity,
      'area': instance.area,
      'beds': instance.beds,
      'quantity': instance.quantity,
      'statusRoom': instance.statusRoom,
      'convenient': instance.convenient,
      'review': instance.review,
      'images': instance.images,
      'description': instance.description,
    };

TypeRoomModel _$TypeRoomModelFromJson(Map<String, dynamic> json) =>
    TypeRoomModel(
      json['idTypeRoom'] as String?,
      json['nameTypeRoom'] as String?,
    );

Map<String, dynamic> _$TypeRoomModelToJson(TypeRoomModel instance) =>
    <String, dynamic>{
      'idTypeRoom': instance.idTypeRoom,
      'nameTypeRoom': instance.nameTypeRoom,
    };

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      json['user'] as String?,
      json['room'] as String?,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      json['numberOfRooms'] as int?,
      json['numberOfAdult'] as int?,
      json['numberOfChildren'] as int?,
      json['promoCode'] as String?,
      (json['services'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['totalPrice'] as num?)?.toDouble(),
      json['isCancelBooking'] as bool?,
      json['isConfirm'] as bool?,
      json['isCheckIn'] as bool?,
      json['isCheckOut'] as bool?,
      json['isPaid'] as bool?,
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'room': instance.room,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'numberOfRooms': instance.numberOfRooms,
      'numberOfAdult': instance.numberOfAdult,
      'numberOfChildren': instance.numberOfChildren,
      'promoCode': instance.promoCode,
      'services': instance.services,
      'totalPrice': instance.totalPrice,
      'isCancelBooking': instance.isCancelBooking,
      'isConfirm': instance.isConfirm,
      'isCheckIn': instance.isCheckIn,
      'isCheckOut': instance.isCheckOut,
      'isPaid': instance.isPaid,
    };

ConvenientModel _$ConvenientModelFromJson(Map<String, dynamic> json) =>
    ConvenientModel(
      json['idConvenient'] as String,
      json['nameConvenient'] as String,
    );

Map<String, dynamic> _$ConvenientModelToJson(ConvenientModel instance) =>
    <String, dynamic>{
      'idConvenient': instance.idConvenient,
      'nameConvenient': instance.nameConvenient,
    };

StatusRoomModel _$StatusRoomModelFromJson(Map<String, dynamic> json) =>
    StatusRoomModel(
      json['idStatus'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$StatusRoomModelToJson(StatusRoomModel instance) =>
    <String, dynamic>{
      'idStatus': instance.idStatus,
      'description': instance.description,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      json['idReview'] as String,
      json['user'] as String,
      json['room'] as String,
      DateTime.parse(json['timeReview'] as String),
      json['detailReview'] as String,
      (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'idReview': instance.idReview,
      'user': instance.user,
      'room': instance.room,
      'timeReview': instance.timeReview.toIso8601String(),
      'detailReview': instance.detailReview,
      'rate': instance.rate,
    };

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      json['idService'] as String?,
      json['nameService'] as String?,
      json['imageService'] as String?,
      (json['priceService'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'idService': instance.idService,
      'nameService': instance.nameService,
      'imageService': instance.imageService,
      'priceService': instance.priceService,
    };

PromoCodeModel _$PromoCodeModelFromJson(Map<String, dynamic> json) =>
    PromoCodeModel(
      json['idPromo'] as String?,
      json['namePromo'] as String?,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      (json['discount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PromoCodeModelToJson(PromoCodeModel instance) =>
    <String, dynamic>{
      'idPromo': instance.idPromo,
      'namePromo': instance.namePromo,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'discount': instance.discount,
    };

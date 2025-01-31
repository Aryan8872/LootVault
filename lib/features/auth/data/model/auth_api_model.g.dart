// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      userId: json['_id'] as String?,
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      image: json['image'] as String?,
      phoneNo: json['phoneNo'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'image': instance.image,
      'phoneNo': instance.phoneNo,
      'email': instance.email,
      'password': instance.password,
    };

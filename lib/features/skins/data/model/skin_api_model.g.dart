// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skin_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkinApiModel _$SkinApiModelFromJson(Map<String, dynamic> json) => SkinApiModel(
      skinId: json['_id'] as String?,
      skinName: json['skinName'] as String,
      skinDescription: json['skinDescription'] as String,
      skinPrice: json['skinPrice'] as String,
      skinPlatform: json['skinPlatform'] as String,
      skinImagePath: json['skinImagePath'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$SkinApiModelToJson(SkinApiModel instance) =>
    <String, dynamic>{
      '_id': instance.skinId,
      'skinName': instance.skinName,
      'skinDescription': instance.skinDescription,
      'skinImagePath': instance.skinImagePath,
      'category': instance.category,
      'skinPrice': instance.skinPrice,
      'skinPlatform': instance.skinPlatform,
    };

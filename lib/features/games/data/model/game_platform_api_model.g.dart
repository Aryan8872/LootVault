// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_platform_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamePlatformApiModel _$GamePlatformApiModelFromJson(
        Map<String, dynamic> json) =>
    GamePlatformApiModel(
      platformId: json['_id'] as String,
      platformName: json['platformName'] as String,
    );

Map<String, dynamic> _$GamePlatformApiModelToJson(
        GamePlatformApiModel instance) =>
    <String, dynamic>{
      '_id': instance.platformId,
      'platformName': instance.platformName,
    };

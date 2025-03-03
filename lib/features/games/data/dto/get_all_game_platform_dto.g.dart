// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_game_platform_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllGamePlatformDto _$GetAllGamePlatformDtoFromJson(
        Map<String, dynamic> json) =>
    GetAllGamePlatformDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GameCategoryApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllGamePlatformDtoToJson(
        GetAllGamePlatformDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };

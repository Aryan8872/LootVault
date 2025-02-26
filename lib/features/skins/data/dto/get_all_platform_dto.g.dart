// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_platform_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPlatformDto _$GetAllPlatformDtoFromJson(Map<String, dynamic> json) =>
    GetAllPlatformDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GameCategoryApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPlatformDtoToJson(GetAllPlatformDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };

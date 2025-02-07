// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_games_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllGameDTO _$GetAllGameDTOFromJson(Map<String, dynamic> json) =>
    GetAllGameDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GameApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllGameDTOToJson(GetAllGameDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };

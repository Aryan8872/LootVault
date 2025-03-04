// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_games_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllGameDTO _$GetAllGameDTOFromJson(Map<String, dynamic> json) =>
    GetAllGameDTO(
      error: json['error'] as bool,
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      games: (json['games'] as List<dynamic>)
          .map((e) => GameApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllGameDTOToJson(GetAllGameDTO instance) =>
    <String, dynamic>{
      'error': instance.error,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'games': instance.games,
    };

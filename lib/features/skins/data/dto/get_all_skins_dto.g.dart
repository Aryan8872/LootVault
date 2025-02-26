// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_skins_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSkinsDTO _$GetAllSkinsDTOFromJson(Map<String, dynamic> json) =>
    GetAllSkinsDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => SkinApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllSkinsDTOToJson(GetAllSkinsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };

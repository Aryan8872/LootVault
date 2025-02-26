// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_gamecategories_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllGamecategoriesDto _$GetAllGamecategoriesDtoFromJson(
        Map<String, dynamic> json) =>
    GetAllGamecategoriesDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GameCategoryApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllGamecategoriesDtoToJson(
        GetAllGamecategoriesDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };

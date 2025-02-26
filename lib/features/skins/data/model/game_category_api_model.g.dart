// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_category_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameCategoryApiModel _$GameCategoryApiModelFromJson(
        Map<String, dynamic> json) =>
    GameCategoryApiModel(
      categoryId: json['_id'] as String,
      categoryName: json['categoryName'] as String,
    );

Map<String, dynamic> _$GameCategoryApiModelToJson(
        GameCategoryApiModel instance) =>
    <String, dynamic>{
      '_id': instance.categoryId,
      'categoryName': instance.categoryName,
    };

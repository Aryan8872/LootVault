// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameApiModel _$GameApiModelFromJson(Map<String, dynamic> json) => GameApiModel(
      gameId: json['_id'] as String?,
      gameName: json['gameName'] as String,
      gameDescription: json['gameDescription'] as String,
      gamePrice: json['gamePrice'] as String,
      gameImagePath: json['gameImagePath'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$GameApiModelToJson(GameApiModel instance) =>
    <String, dynamic>{
      '_id': instance.gameId,
      'gameName': instance.gameName,
      'gameDescription': instance.gameDescription,
      'gameImagePath': instance.gameImagePath,
      'category': instance.category,
      'gamePrice': instance.gamePrice,
    };

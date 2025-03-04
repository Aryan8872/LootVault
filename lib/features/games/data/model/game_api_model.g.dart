// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameApiModel _$GameApiModelFromJson(Map<String, dynamic> json) => GameApiModel(
      gameId: json['_id'] as String?,
      gamePlatform: json['gamePlatform'],
      gameName: json['gameName'] as String,
      gameDescription: json['gameDescription'] as String,
      gamePrice: json['gamePrice'] as num,
      gameImagePath: json['gameImagePath'] as String,
      category: json['category'],
    );

Map<String, dynamic> _$GameApiModelToJson(GameApiModel instance) =>
    <String, dynamic>{
      '_id': instance.gameId,
      'gameName': instance.gameName,
      'gameDescription': instance.gameDescription,
      'gameImagePath': instance.gameImagePath,
      'category': instance.category,
      'gamePrice': instance.gamePrice,
      'gamePlatform': instance.gamePlatform,
    };

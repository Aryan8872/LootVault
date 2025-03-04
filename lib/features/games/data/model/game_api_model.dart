import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';

part 'game_api_model.g.dart';

@JsonSerializable()
class GameApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? gameId;
  final String gameName;
  final String gameDescription;
  final String gameImagePath;
  final dynamic category;
  final num gamePrice;
  final dynamic gamePlatform;

  const GameApiModel(
      {required this.gameId,
      required this.gamePlatform,
      required this.gameName,
      required this.gameDescription,
      required this.gamePrice,
      required this.gameImagePath,
      required this.category});

  factory GameApiModel.fromJson(Map<String, dynamic> json) =>
      _$GameApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameApiModelToJson(this);

  GameEntity toEntity(){
    return GameEntity(
      gameId: gameId,
      gamePlatform: gamePlatform,
      gameDescription: gameDescription,
      category: category,
      gamePrice: gamePrice,
      gameImagePath: gameImagePath,
      gameName: gameName
      );
  }

  factory GameApiModel.fromEntity(GameEntity entity){
    return GameApiModel(
      gamePlatform: entity.gamePlatform,
      gameName: entity.gameName,
      gameDescription: entity.gameDescription,
      gameImagePath: entity.gameImagePath,
      gameId: entity.gameId,
      category: entity.category,
      gamePrice: entity.gamePrice,
    );
  }
  static List<GameEntity> toEntityList(List<GameApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props =>
      [gameId, gameName, gameImagePath,gamePlatform, gameDescription, category, gamePrice];
}

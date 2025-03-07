import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:loot_vault/app/constants/hive_table_constant.dart';


// dart run build_runner build -d

part 'game_hive_model.g.dart';

@HiveType(typeId:HiveTableConstant.gameTableId )
class GameHiveModel extends Equatable {
  @HiveField(0)
  final String? gameId;
  @HiveField(1)
  final String gameName;
  @HiveField(2)
  final String gameDescription;

  @HiveField(3)
  final String gameImagePath;

  @HiveField(4)
  final String category;

  @HiveField(5)
    final num gamePrice;

    @HiveField(6)
    final String gamePlatform;

   GameHiveModel(
      {String? gameId,
      required this.gameName,
      required this.gameDescription,
      required this.gameImagePath,
      required this.category,
      required this.gamePlatform,
      required this.gamePrice,

      }):gameId= gameId?? const Uuid().v4();


  const GameHiveModel.initial({
    this.gameId="",
    this.gameName= "",
    this.gameDescription="",
    this.gameImagePath="",
    this.category="",
    this.gamePrice=0,
    this.gamePlatform = ""
 
  });

  factory GameHiveModel.fromEntity(GameEntity entity){
    return GameHiveModel(
      gameName: entity.gameName,
      gameDescription: entity.gameDescription,
      gameImagePath: entity.gameImagePath,
      gameId: entity.gameId,
      category: entity.category,
      gamePrice: entity.gamePrice,
      gamePlatform:  entity.gamePlatform,
    );
  }
  GameEntity toEntity(){
    return GameEntity(
      gameId: gameId,
      gameDescription: gameDescription,
      category: category,
      gamePrice: gamePrice,
      gameImagePath: gameImagePath,
      gamePlatform: gamePlatform,
      gameName: gameName
      );
  }

    static List<GameHiveModel> fromEntitytoList(List<GameEntity> entities) {
    return entities.map((e) => GameHiveModel.fromEntity(e)).toList();
  }

  static List<GameEntity> toEntityList(List<GameHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }
  @override
  List<Object?> get props => [gameId];
}

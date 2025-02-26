import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/data/data_source/local_data_source/game_local_data_source.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class GameLocalRepository implements IGameRepository{
  final GameLocalDataSource gameLocalDataSource;

  GameLocalRepository({required this.gameLocalDataSource});


  @override
  Future<Either<Failure, void>> createGame(GameEntity entity) {
    try{
      gameLocalDataSource.createGame(entity);
      return Future.value(Right(null));

    }
    catch(e){
      return Future.value(Left(LocalDatabaseFailure(message: '${e}')));
    }
  }

  @override
  Future<Either<Failure, List<GameEntity>>> getAllGames() {
    // TODO: implement getAllGames
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> uploadGamePicture(File file) {
    // TODO: implement uploadGamePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<GameCategoryEntity>>> getallGameCategories() {
    // TODO: implement getallGameCategories
    throw UnimplementedError();
  }

}
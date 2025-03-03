import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/data/data_source/remote_data_source/game_remote_data_source.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class GameRemoteRepository implements IGameRepository {
  final GameRemoteDataSource gameRemoteDataSource;

  GameRemoteRepository({required this.gameRemoteDataSource});

  @override
  Future<Either<Failure, void>> createGame(GameEntity entity) async {
    try {
      print("create garda in repo ${entity.gameImagePath}");
      await gameRemoteDataSource.createGame(entity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GameEntity>>> getAllGames() async {
    try {
      final games = await gameRemoteDataSource.getallGames();
      return Right(games);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadGamePicture(File file) async {
    try {
      await gameRemoteDataSource.uploadGamePicture(file);
      return Right(file.path.split("/").last);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GameCategoryEntity>>>
      getallGameCategories() async {
    try {
      final categories = await gameRemoteDataSource.getallGameCategories();
      return Right(categories);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GamePlatformEntity>>> getAllPlatform() async {
    try {
      final platforms = await gameRemoteDataSource.getallPlatorm();
      return Right(platforms);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

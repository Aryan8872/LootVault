import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';

abstract interface class IGameRepository {
  Future<Either<Failure, void>> createGame(GameEntity entity);
  Future<Either<Failure, List<GameEntity>>> getAllGames();
  Future<Either<Failure, String>> uploadGamePicture(File file);
  Future<Either<Failure, List<GameCategoryEntity>>> getallGameCategories();
  Future<Either<Failure, List<GamePlatformEntity>>> getAllPlatform();
}

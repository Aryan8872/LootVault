import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/data/data_source/local_data_source/game_local_data_source.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';
import 'package:loot_vault/features/skins/data/data_source/local_data_source/skin_local_data_source.dart';
import 'package:loot_vault/features/skins/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';
import 'package:loot_vault/features/skins/domain/repository/skin_repository.dart';

class SkinLocalRepository implements ISkinRepository {
  final SkinLocalDataSource gameLocalDataSource;

  SkinLocalRepository({required this.gameLocalDataSource});

  // @override
  // Future<Either<Failure, void>> createSkin(SkinEntity entity) {
  //   try {
  //     gameLocalDataSource.createGame(entity);
  //     return Future.value(const Right(null));
  //   } catch (e) {
  //     return Future.value(Left(LocalDatabaseFailure(message: '$e')));
  //   }
  // }

  @override
  Future<Either<Failure, List<SkinEntity>>> getAllSkins() {
    // TODO: implement getAllGames
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadSkinPicture(File file) {
    // TODO: implement uploadGamePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PlatformEntity>>> getallSkinPlatform() {
    // TODO: implement getallGameCategories
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> createGame(GameEntity entity) {
    // TODO: implement createGame
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<GameEntity>>> getAllGames() {
    // TODO: implement getAllGames
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<GameCategoryEntity>>> getallGameCategories() {
    // TODO: implement getallGameCategories
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> uploadGamePicture(File file) {
    // TODO: implement uploadGamePicture
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> createSkin(SkinEntity entity) {
    // TODO: implement createSkin
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<PlatformEntity>>> getAllPlatform() {
    print("hove ma xa");
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<GameCategoryEntity>>> getallskinCategories() {
    // TODO: implement getallskinCategories
    throw UnimplementedError();
  }
}

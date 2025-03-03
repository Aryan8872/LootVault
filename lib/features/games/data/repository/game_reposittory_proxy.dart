import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/common/internet_checker/internet_checker.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/data/repository/game_local_repository.dart';
import 'package:loot_vault/features/games/data/repository/game_remote_repository.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class GameRepositoryProxy implements IGameRepository {
  final IInternetChecker internetChecker;
  final GameRemoteRepository remoteRepository;
  final GameLocalRepository localRepository;

  GameRepositoryProxy({
    required this.internetChecker,
    required this.remoteRepository,
    required this.localRepository,
  });

  // @override
  // Future<Result> getAllGames() async {
  //   final isConnected = await internetChecker.isConnected();
  //   if (isConnected) {
  //     try {
  //       final result = await remoteRepository.getAllGames();
  //       // Save the result to local storage for offline use
  //       await localRepository.saveGames(result);
  //       return result;
  //     } catch (e) {
  //       // If remote fails, fall back to local
  //       return await localRepository.getAllGames();
  //     }
  //   } else {
  //     // No internet, use local data
  //     return await localRepository.getAllGames();
  //   }
  // }

  @override
  Future<Either<Failure, void>> createGame(GameEntity entity) {
    // TODO: implement createGame
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<GamePlatformEntity>>> getAllPlatform() {
    // TODO: implement getAllPlatform
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
  Future<Either<Failure, List<GameEntity>>> getAllGames() {
    // TODO: implement getAllGames
    throw UnimplementedError();
  }

}
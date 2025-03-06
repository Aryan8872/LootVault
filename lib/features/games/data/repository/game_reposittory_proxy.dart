import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/common/internet_checker/connectivity_listener.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/data/repository/game_local_repository.dart';
import 'package:loot_vault/features/games/data/repository/game_remote_repository.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class GameRepositoryProxy implements IGameRepository {
  final ConnectivityListener connectivityListener;
  final GameRemoteRepository remoteRepository;
  final GameLocalRepository localRepository;

  GameRepositoryProxy({
    required this.connectivityListener,
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
  Future<Either<Failure, void>> createGame(GameEntity entity)async {
    if (await connectivityListener.isConnected) {
      // ✅ Fetch latest status
      try {
        print("Connected to the internet");
        return await remoteRepository.createGame(entity);
      } catch (e) {
        print("Remote call failed, falling back to local storage");
        return await localRepository.createGame(entity);
      }
    } else {
      print("No internet, saving post locally");
      return await localRepository.createGame(entity);
    }
  }

  @override
  Future<Either<Failure, List<GamePlatformEntity>>> getAllPlatform() async{
       if (await connectivityListener.isConnected) {
      // ✅ Fetch latest status
      try {
        print("Connected to the internet");
        return await remoteRepository.getAllPlatform();
      } catch (e) {
        print("Remote call failed, falling back to local storage");
        return await localRepository.getAllPlatform();
      }
    } else {
      print("No internet, saving post locally");
      return await localRepository.getAllPlatform();
    }
  }

  @override
  Future<Either<Failure, List<GameCategoryEntity>>> getallGameCategories()async {
    if (await connectivityListener.isConnected) {
      // ✅ Fetch latest status
      try {
        print("Connected to the internet");
        return await remoteRepository.getallGameCategories();
      } catch (e) {
        print("Remote call failed, falling back to local storage");
        return await localRepository.getallGameCategories();
      }
    } else {
      print("No internet, saving post locally");
      return await localRepository.getallGameCategories();
    }
  }

  @override
  Future<Either<Failure, String>> uploadGamePicture(File file) async{
        if (await connectivityListener.isConnected) {
      // ✅ Fetch latest status
      try {
        print("Connected to the internet");
        return await remoteRepository.uploadGamePicture(file);
      } catch (e) {
        print("Remote call failed, falling back to local storage");
        return await localRepository.uploadGamePicture(file);
      }
    } else {
      print("No internet, saving post locally");
      return await localRepository.uploadGamePicture(file);
    }
  }
  
  @override
  Future<Either<Failure, List<GameEntity>>> getAllGames() async{
       if (await connectivityListener.isConnected) {
      // ✅ Fetch latest status
      try {
        print("Connected to the internet");
        
         final eitherGames = await remoteRepository.getAllGames();

      return eitherGames.fold(
        (failure) {
          print("Remote call failed, falling back to local storage");
          return localRepository.getAllGames();
        },
        (games) async {
          // ✅ Save to Hive database
         // ✅ Save each game individually
          for (var game in games) {
            await localRepository.createGame(game);
          }
          return Right(games);
        },
      );
      
      } catch (e) {
        print("Remote call failed, falling back to local storage");
        return await localRepository.getAllGames();
      }
    } else {
      print("No internet, saving post locally");
      return await localRepository.getAllGames();
    }
  }

}
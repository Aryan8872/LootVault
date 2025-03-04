import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class CreateGameParams extends Equatable {
  final String gameName;
  final String gameDescription;
  final String gameImagePath;
  final String category;
  final num gamePrice;
  final String gamePlatform;

  const CreateGameParams(
      {required this.gameName,
      required this.gameDescription,
      required this.gamePrice,
      required this.gamePlatform,
      required this.category,
      required this.gameImagePath});

  const CreateGameParams.initial()
      : gameName = '',
        gameDescription = '',
        gamePrice = 0,
        category = '',
        gamePlatform = '',
        gameImagePath = '';

  @override
  List<Object?> get props =>
      [gameName, gameDescription, gamePrice, category, gameImagePath,gamePlatform];
}

class CreateGameUsecase implements UsecaseWithParams<void, CreateGameParams> {
  final IGameRepository gameRepository;

  CreateGameUsecase({required this.gameRepository});

  @override
  Future<Either<Failure, void>> call(CreateGameParams params) {
    final gameEntity = GameEntity(
      gameName: params.gameName,
      gamePlatform:  params.gamePlatform,
      category: params.category,
      gameDescription: params.gameDescription,
      gameImagePath: params.gameImagePath,
      gamePrice: params.gamePrice,
      
    );

    return gameRepository.createGame(gameEntity);
  }
}

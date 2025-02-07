import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';




class GetallgamesUsecase implements UsecaseWithoutParams<List<GameEntity>>{
  final IGameRepository gameRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetallgamesUsecase({required this.gameRepository, required this.tokenSharedPrefs});
  
  @override
  Future<Either<Failure, List<GameEntity>>> call() {
    // TODO: implement call
    return gameRepository.getAllGames();
  }




  
}
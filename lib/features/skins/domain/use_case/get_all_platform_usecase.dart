
import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/skins/domain/repository/skin_repository.dart';

class GetallPlatformUsecase implements UsecaseWithoutParams<List<GameCategoryEntity>>{
  final ISkinRepository gameRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetallPlatformUsecase({required this.gameRepository, required this.tokenSharedPrefs});
  
  @override
  Future<Either<Failure, List<GameCategoryEntity>>> call() {
    print("repo vitra cat");
    return gameRepository.getAllPlatform();
  }




  
}
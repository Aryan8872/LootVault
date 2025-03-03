import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class GetallCategoriesUsecase
    implements UsecaseWithoutParams<List<GameCategoryEntity>> {
  final IGameRepository gameRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetallCategoriesUsecase(
      {required this.gameRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, List<GameCategoryEntity>>> call() {
    print("repo vitra cat");
    return gameRepository.getallGameCategories();
  }
}

import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class GetallGamePlatformUsecase
    implements UsecaseWithoutParams<List<GamePlatformEntity>> {
  final IGameRepository gameRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetallGamePlatformUsecase(
      {required this.gameRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, List<GamePlatformEntity>>> call() {
    print("repo vitra plat");
    return gameRepository.getAllPlatform();
  }
}

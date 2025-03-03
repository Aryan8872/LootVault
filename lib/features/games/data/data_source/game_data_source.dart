import 'dart:io';

import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';

abstract interface class IGameDataSource {
  Future<void> createGame(GameEntity entity);
  Future<List<GameEntity>> getallGames();
  Future<String> uploadGamePicture(File? file);
  Future<List<GameCategoryEntity>> getallGameCategories();
  Future<List<GamePlatformEntity>> getallPlatorm();
}

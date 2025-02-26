import 'dart:io';

import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

abstract interface class ISkinsDataSource {
  Future<void> createSkin(SkinEntity entity);
  Future<List<SkinEntity>> getallSkins();
  Future<String> uploadSkinPicture(File? file);
  Future<List<GameCategoryEntity>> getallSkinCategories();
  Future<List<PlatformEntity>> getallPlatorm();
}

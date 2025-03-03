import 'dart:io';

import 'package:loot_vault/core/network/hive_service.dart';
import 'package:loot_vault/features/games/data/data_source/game_data_source.dart';
import 'package:loot_vault/features/games/data/model/game_hive_model.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/skins/data/data_source/skins_data_source.dart';
import 'package:loot_vault/features/skins/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

class SkinLocalDataSource implements ISkinsDataSource {
  final HiveService hiveService;

  SkinLocalDataSource({required this.hiveService});

  @override
  Future<List<GameEntity>> getallGames() async {
    try {
      var data = await hiveService.getAllGames().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> createGame(GameEntity entity) async {
    try {
      var userModel = GameHiveModel.fromEntity(entity);
      await hiveService.createGame(userModel);
      getallGames();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadGamePicture(File? file) {
    // TODO: implement uploadGamePicture
    throw UnimplementedError();
  }

  @override
  Future<List<GameCategoryEntity>> getallGameCategories() {
    // TODO: implement getallGameCategories
    throw UnimplementedError();
  }

  @override
  Future<void> createSkin(SkinEntity entity) {
    // TODO: implement createSkin
    throw UnimplementedError();
  }

  @override
  Future<List<PlatformEntity>> getallPlatorm() {
    // TODO: implement getallPlatorm
    throw UnimplementedError();
  }

  @override
  Future<List<GameCategoryEntity>> getallSkinCategories() {
    // TODO: implement getallSkinCategories
    throw UnimplementedError();
  }

  @override
  Future<List<SkinEntity>> getallSkins() {
    // TODO: implement getallSkins
    throw UnimplementedError();
  }

  @override
  Future<String> uploadSkinPicture(File? file) {
    // TODO: implement uploadSkinPicture
    throw UnimplementedError();
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

abstract interface class ISkinRepository {
  Future<Either<Failure, void>> createSkin(SkinEntity entity);
  Future<Either<Failure, List<SkinEntity>>> getAllSkins();
  Future<Either<Failure, String>> uploadSkinPicture(File file);
  Future<Either<Failure, List<GameCategoryEntity>>> getallskinCategories();
  Future<Either<Failure, List<PlatformEntity>>> getAllPlatform();
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/skins/data/data_source/remote_data_source/skin_remote_data_source.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';
import 'package:loot_vault/features/skins/domain/repository/skin_repository.dart';


class SkinRemoteRepository implements ISkinRepository {
  final SkinRemoteDataSource skinRemoteDataSource;

  SkinRemoteRepository({required this.skinRemoteDataSource});

  @override
  Future<Either<Failure, void>> createSkin(SkinEntity entity) async {
    try {
      print("create garda in repo ${entity.skinImagePath}");
      await skinRemoteDataSource.createSkin(entity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SkinEntity>>> getAllSkins()async {
    try {
      final skins = await skinRemoteDataSource.getallSkins();
      return  Right(skins);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadSkinPicture(File file) async {
    try {
      await skinRemoteDataSource.uploadSkinPicture(file);
      return  Right(file.path.split("/").last);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GameCategoryEntity>>>
      getallskinCategories() async {
    try {
      final categories = await skinRemoteDataSource.getallSkinCategories();
      return Right(categories);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

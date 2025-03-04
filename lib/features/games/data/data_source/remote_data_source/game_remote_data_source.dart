import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/features/games/data/data_source/game_data_source.dart';
import 'package:loot_vault/features/games/data/model/game_api_model.dart';
import 'package:loot_vault/features/games/data/model/game_category_api_model.dart';
import 'package:loot_vault/features/games/data/model/game_platform_api_model.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';

class GameRemoteDataSource implements IGameDataSource {
  final Dio _dio;

  GameRemoteDataSource(this._dio);

  @override
  Future<void> createGame(GameEntity entity) async {
    try {
      print("data source ma ${entity.gameImagePath}");
      Response response = await _dio.post(ApiEndpoints.addGame, data: {
        "gameName": entity.gameName,
        "gameDescription": entity.gameDescription,
        "gamePrice": entity.gamePrice,
        "gameImagePath": entity.gameImagePath,
        "category": entity.category,
        "gamePlatform": entity.gamePlatform,
      });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<GameEntity>> getallGames() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllgames);
      if (response.statusCode == 200) {

        // Extract the "games" list from the API response
        final gamesData = response.data['games'] as List;

        // Convert each game JSON into a GameApiModel instance
        List<GameApiModel> gamedataList = gamesData
            .map((game) => GameApiModel.fromJson(game as Map<String, dynamic>))
            .toList();


        return GameApiModel.toEntityList(gamedataList);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadGamePicture(File? file) async {
    try {
      if (file == null || !file.existsSync()) {
        throw Exception("File not found");
      }
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename:
              file.path.split('/').last, // Use the filename from the file path
        ),
      });
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return "image uploaded sucessfully";
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<GameCategoryEntity>> getallGameCategories() async {
    try {
      var response = await _dio.get(ApiEndpoints.getallGameCategories);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final categories =
            data.map((json) => GameCategoryApiModel.fromJson(json)).toList();

        return GameCategoryApiModel.toEntityList(categories);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      throw Exception(e);
    } catch (e) {
      print("General Exception: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<GamePlatformEntity>> getallPlatorm() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllPlatform);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final platforms =
            data.map((json) => GamePlatformApiModel.fromJson(json)).toList();

        return GamePlatformApiModel.toEntityList(platforms);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      throw Exception(e);
    } catch (e) {
      print("General Exception: $e");
      throw Exception(e);
    }
  }
}

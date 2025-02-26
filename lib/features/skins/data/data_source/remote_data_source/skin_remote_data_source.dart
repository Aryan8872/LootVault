import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/features/games/data/model/game_category_api_model.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/skins/data/data_source/skins_data_source.dart';
import 'package:loot_vault/features/skins/data/dto/get_all_skins_dto.dart';
import 'package:loot_vault/features/skins/data/model/platform_api_model.dart';
import 'package:loot_vault/features/skins/data/model/skin_api_model.dart';
import 'package:loot_vault/features/skins/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

class SkinRemoteDataSource implements ISkinsDataSource {
  final Dio _dio;

  SkinRemoteDataSource(this._dio);

  @override
  Future<void> createSkin(SkinEntity entity) async {
    try {
      print("data source ma ${entity.skinImagePath}");
      Response response = await _dio.post(ApiEndpoints.addSkins, data: {
        "skinName": entity.skinName,
        "skinDescription": entity.skinDescription,
        "skinPrice": entity.skinPrice,
        "skinImagePath": entity.skinImagePath,
        "category": entity.category,
        "skinPlatform":entity.skinPlatform
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
  Future<List<SkinEntity>> getallSkins() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllSkins);
      if (response.statusCode == 200) {
        GetAllSkinsDTO skinaddDTO = GetAllSkinsDTO.fromJson(response.data);
        return SkinApiModel.toEntityList(skinaddDTO.data);
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
  Future<String> uploadSkinPicture(File? file) async {
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
  Future<List<GameCategoryEntity>> getallSkinCategories() async {
    try {
      print("Data source fetching categories...");
      var response = await _dio.get(ApiEndpoints.getallGameCategories);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print("Raw API Data: $data");

        final categories =
            data.map((json) => GameCategoryApiModel.fromJson(json)).toList();

        print("Mapped Categories: $categories");
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
  Future<List<PlatformEntity>> getallPlatorm() async{
     try {
      print("Data source fetching categories...");
      var response = await _dio.get(ApiEndpoints.getAllPlatform);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print("Raw API Data: $data");

        final platforms =
            data.map((json) => PlatformApiModel.fromJson(json)).toList();

        print("Mapped Categories: $platforms");
        return PlatformApiModel.toEntityList(platforms);
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

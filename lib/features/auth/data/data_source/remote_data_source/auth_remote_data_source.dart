import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/features/auth/data/data_source/auth_data_source.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';


class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<String> uploadProfilePicture(File? file) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          file!.path,
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
  Future<void> createUser(AuthEntity entity)async {
    try {
      Response response = await _dio.post(ApiEndpoints.registerStudent, data: {
        "fullName": entity.fullName,
        "username": entity.username,
        "email": entity.email,
        "phoneNo": entity.phoneNo,
        "password": entity.password,
        "image":entity.image
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
  Future<List<AuthHiveModel>> getalluser() {
    // TODO: implement getalluser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(ApiEndpoints.loginStudent,
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return "logged in sucessfully";
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}

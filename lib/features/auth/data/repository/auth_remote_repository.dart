import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepository({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      print("remote repository $file");
      await authRemoteDataSource.uploadProfilePicture(file);
      return const Right("upload image uploaded in remote repository");
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createUser(AuthEntity entity) async {
    try {
      await authRemoteDataSource.createUser(entity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {
    try {
      final response = await authRemoteDataSource.loginUser(email, password);
      print('Repository login response: $response'); // Debug log
      return Right(response); // Expecting JSON string here
    } catch (e) {
      return Left(ApiFailure(message: "Login failed: ${e.toString()}"));
    }
  }
}
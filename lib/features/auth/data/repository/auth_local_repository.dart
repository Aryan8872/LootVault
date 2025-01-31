import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository{
  final AuthLocalDataSource authLocalDataSource;

  AuthLocalRepository({required this.authLocalDataSource});
  @override
  Future<Either<Failure, void>> createUser(AuthEntity entity) {
    try{
      authLocalDataSource.createUser(entity);
      return Future.value(Right(null));

    }
    catch(e){
      return Future.value(Left(LocalDatabaseFailure(message: '${e}')));
    }
  }

  @override
Future<Either<Failure, String>> loginUser(String username, String password) async {
  try {
    final token = await authLocalDataSource.loginUser(username, password);
    return Right(token);
  } catch (e) {
    return Left(LocalDatabaseFailure(message: "Login failed: ${e.toString()}"));
  }
}

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

}
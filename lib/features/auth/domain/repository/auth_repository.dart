import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> createUser(AuthEntity entity);
  Future<Either<Failure, String>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, AuthEntity>> updateProfile(AuthEntity user);
  Future<Either<Failure, AuthEntity>> getUserdata(String userId);

  Future<void> changePassword(
      String userId, String currentPassword, String newPassword);
}

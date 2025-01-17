import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository{
  Future<Either<Failure,void>>createUser(AuthEntity entity);
  Future<Either<Failure,String>>loginUser(String username,String password); 


}
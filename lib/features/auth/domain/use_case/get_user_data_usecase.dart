import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';

class GetUserParams extends Equatable {
  final String userId;

  const GetUserParams.initial() : userId = '';

  @override
  List<Object?> get props => [userId];
}

class GetUserDataUsecase
    implements UsecaseWithParams<AuthEntity, GetUserParams> {
  final IAuthRepository authRepository;

  GetUserDataUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(GetUserParams params) async {
    return await authRepository.getUserdata(params.userId);
  }
}

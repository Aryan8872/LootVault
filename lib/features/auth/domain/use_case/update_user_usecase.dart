import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';

class UpdateUserParams extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String username;
  final String phoneNo;
  final String password;
  final String? image;

  const UpdateUserParams(
      {required this.fullName,
      required this.email,
      required this.userId,
      required this.username,
      required this.phoneNo,
      required this.password,
      this.image});

  const UpdateUserParams.initial()
      : fullName = '',
        email = '',
        userId='',
        username = '',
        phoneNo = '',
        password = '',
        image = '';

  @override
  List<Object?> get props =>
      [fullName, email, userId,username, phoneNo, password, image];
}

class UpdateUserUsecase
    implements UsecaseWithParams<AuthEntity, UpdateUserParams> {
  final IAuthRepository authRepository;

  UpdateUserUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(UpdateUserParams params) {
    final authEntity = AuthEntity(
        username: params.username,
        userId: params.userId,
        fullName: params.fullName,
        email: params.email,
        phoneNo: params.phoneNo,
        image: params.image,
        password: params.password);

    return authRepository.updateProfile(authEntity);
  }
}

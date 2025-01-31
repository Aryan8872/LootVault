import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
  final String email;
  final String username;
  final String phoneNo;
  final String password;
  final String? image;

  const RegisterUserParams(
      {required this.fullName,
      required this.email,
      required this.username,
      required this.phoneNo,
      required this.password,
      this.image});

  const RegisterUserParams.initial()
      : fullName = '',
        email = '',
        username = '',
        phoneNo = '',
        password = '',
        image = '';

  @override
  List<Object?> get props =>
      [fullName, email, username, phoneNo, password, image];
}

class RegisterUserUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository authRepository;

  RegisterUserUsecase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
        username: params.username,
        fullName: params.fullName,
        email: params.email,
        phoneNo: params.phoneNo,
        image: params.image,
        password: params.password);

    return authRepository.createUser(authEntity);
  }
}

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/login_response.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object?> get props => [email, password];
}

class LoginUsecase implements UsecaseWithParams<LoginResponse, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUsecase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    final result = await repository.loginUser(params.email, params.password);
    return result.fold(
      (failure) => Left(failure),
      (jsonString) {
        try {
          final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
          return Right(LoginResponse.fromJson(jsonMap));
        } catch (e) {
          return Left(ApiFailure(message: 'Failed to parse login response: $e'));
        }
      },
    );
  }
}
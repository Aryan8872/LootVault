import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUserUsecase usecase; // Use RegisterUserUsecase instead of UpdateUserUsecase

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUserUsecase(authRepository: repository); // Initialize RegisterUserUsecase
    registerFallbackValue(const AuthEntity.initial());
  });

  const params = RegisterUserParams.initial(); // Use RegisterUserParams

  test('should register user successfully', () async {
    when(() => repository.createUser(any())).thenAnswer(
      (_) async => const Right(null),
    );

    final result = await usecase(params);

    expect(result, const Right(null));
    verify(() => repository.createUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return ApiFailure when user registration fails', () async {
    // Arrange
    final failure = ApiFailure(message: "Registration failed");
    when(() => repository.createUser(any())).thenAnswer(
      (_) async => Left(failure),
    );

    final result = await usecase(params);

    expect(result, Left(failure));

    verify(() => repository.createUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
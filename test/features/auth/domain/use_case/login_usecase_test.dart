import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/login_response.dart';
import 'package:loot_vault/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late LoginUsecase usecase;
  late MockTokenSharedPrefs tokenSharedPrefs;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUsecase(repository, tokenSharedPrefs);
  });

  test("should call the authrepo.login with correct username and password",
      () async {
    // Arrange
    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      if (email == "i@gmail.com" && password == "ishiki123") {
        // Return a JSON string that matches the expected structure of LoginResponse
        return const Right('{"accessToken": "token", "refreshToken": "refreshToken", "user": {"id": "1", "email": "i@gmail.com", "role": "user"}}');
      } else {
        return Left(ApiFailure(message: "invalid email or password"));
      }
    });

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right<Failure, void>(null));

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right<Failure, String>('token'));

    // Act
    final result = await usecase(
        const LoginParams(email: "i@gmail.com", password: "ishiki123"));

    // Assert
    expect(result, isA<Right<Failure, LoginResponse>>());
    expect(
        result.getOrElse(() => LoginResponse(
              accessToken: '',
              refreshToken: '',
              user: User(id: '', email: '', role: ''),
            )).accessToken,
        'token');

    verify(() => repository.loginUser("i@gmail.com", "ishiki123")).called(1);
    verify(() => tokenSharedPrefs.saveToken('token')).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  test("should return ApiFailure when credentials are invalid", () async {
    // Arrange
    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      if (email != "i@gmail.com" || password != "ishiki123") {
        return Left(ApiFailure(message: "invalid email or password"));
      } else {
        return const Right(
            '{"accessToken": "token", "refreshToken": "refreshToken", "user": {"id": "1", "email": "i@gmail.com", "role": "user"}}');
      }
    });

    // Act
    final result = await usecase(
        const LoginParams(email: "wrong@gmail.com", password: "wrongpass"));

    // Assert
    expect(result, isA<Left<Failure, LoginResponse>>());
    expect((result as Left<Failure, LoginResponse>).value.message,
        equals("invalid email or password"));

    verify(() => repository.loginUser("wrong@gmail.com", "wrongpass"))
        .called(1);
    verifyNever(() => tokenSharedPrefs.saveToken(any()));
    verifyNever(() => tokenSharedPrefs.getToken());

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}

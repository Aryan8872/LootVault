import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/entity/login_response.dart';
import 'package:loot_vault/features/auth/domain/use_case/login_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'login_bloc.mock.dart'; // Ensure your mocks are set up

// Registering fallback value for LoginParams
void main() {
  setUpAll(() {
    // Register a fallback value for LoginParams
    registerFallbackValue(LoginParams(email: '', password: ''));
  });

  late LoginBloc loginBloc;
  late MockLoginUsecase mockLoginUsecase;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    mockHomeCubit = MockHomeCubit();

    loginBloc = LoginBloc(
      registerBloc: MockRegisterBloc(),
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUsecase,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  tearDown(() {
    loginBloc.close();
  });

  // Test case for successful login
  blocTest<LoginBloc, LoginState>(
    'emits [loading, success] when login is successful',
    build: () {
      when(() => mockLoginUsecase.call(any())).thenAnswer(
        (_) async => Right(LoginResponse(
          accessToken: 'dummy_token',
          refreshToken: 'dummy_refresh_token',
          user: User(id: '123', email: 'test@example.com', role: 'buyer'),
        )),
      );
      when(() => mockTokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockTokenSharedPrefs.saveUserData(any()))
          .thenAnswer((_) async => const Right(null));

      return loginBloc;
    },
    act: (bloc) => bloc.add(LoginUserEvent(
      context: MockBuildContext(),
      email: 'test@example.com',
      password: 'password',
    )),
    expect: () => [
      LoginState(isLoading: true, isSuccess: false),
      LoginState(isLoading: false, isSuccess: true),
    ],
    verify: (_) {
      verify(() => mockLoginUsecase.call(any())).called(1);
      verify(() => mockTokenSharedPrefs.saveToken(any())).called(1);
      verify(() => mockTokenSharedPrefs.saveUserData(any())).called(1);
    },
  );

  // Test case for failure scenario
  blocTest<LoginBloc, LoginState>(
    'emits [loading, failure] when login fails',
    build: () {
      when(() => mockLoginUsecase.call(any()))
          .thenAnswer((_) async => Left(Failure(message: 'Login failed')));
      return loginBloc;
    },
    act: (bloc) => bloc.add(LoginUserEvent(
      context: MockBuildContext(),
      email: 'test@example.com',
      password: 'password',
    )),
    expect: () => [
      LoginState(isLoading: true, isSuccess: false),
      LoginState(isLoading: false, isSuccess: false),
    ],
    verify: (_) {
      verify(() => mockLoginUsecase.call(any())).called(1);
    },
  );
}

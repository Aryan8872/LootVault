import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'register_bloc.mock.dart';

// Mock classes

void main() {
  late RegisterBloc registerBloc;
  late MockRegisterUserUsecase mockRegisterUserUsecase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late MockBuildContext mockContext;

  setUpAll(() {
    registerFallbackValue(const RegisterUserParams(
      fullName: 'Test User',
      email: 'test@example.com',
      username: 'testuser',
      image: 'path/to/image',
      phoneNo: '1234567890',
      password: 'password123',
    ));
    registerFallbackValue(UploadImageParams(image: File('path/to/image')));
  });

  setUp(() {
    mockRegisterUserUsecase = MockRegisterUserUsecase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    mockContext = MockBuildContext();

    registerBloc = RegisterBloc(
      registerUserUsecase: mockRegisterUserUsecase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  tearDown(() {
    registerBloc.close();
  });

  // Test case for successful user registration
  blocTest<RegisterBloc, RegisterState>(
    'emits [loading, success] when registration is successful',
    build: () {
      when(() => mockRegisterUserUsecase.call(any()))
          .thenAnswer((_) async => Right(null)); // Simulating success

      return registerBloc;
    },
    act: (bloc) => bloc.add(RegisterUser(
      context: mockContext,
      fullName: 'Test User',
      email: 'test@example.com',
      userName: 'testuser',
      image: 'path/to/image',
      phoneNo: '1234567890',
      password: 'password123',
    )),
    expect: () => [
      RegisterState(isLoading: true, isSuccess: false),
      RegisterState(isLoading: false, isSuccess: true),
    ],
    verify: (_) {
      verify(() => mockRegisterUserUsecase.call(any())).called(1);
    },
  );

  // Test case for failed user registration
  blocTest<RegisterBloc, RegisterState>(
    'emits [loading, failure] when registration fails',
    build: () {
      when(() => mockRegisterUserUsecase.call(any())).thenAnswer(
          (_) async => Left(Failure(message: 'Registration failed')));

      return registerBloc;
    },
    act: (bloc) => bloc.add(RegisterUser(
      context: mockContext,
      fullName: 'Test User',
      email: 'test@example.com',
      userName: 'testuser',
      image:'path/to/image',
      phoneNo: '1234567890',
      password: 'password123',
    )),
    expect: () => [
      RegisterState(isLoading: true, isSuccess: false),
      RegisterState(isLoading: false, isSuccess: false),
    ],
    verify: (_) {
      verify(() => mockRegisterUserUsecase.call(any())).called(1);
    },
  );

  // Test case for successful image upload
  blocTest<RegisterBloc, RegisterState>(
    'emits [loading, success] when image upload is successful',
    build: () {
      when(() => mockUploadImageUsecase.call(any()))
          .thenAnswer((_) async => Right(null)); // Simulating success

      return registerBloc;
    },
    act: (bloc) => bloc.add(UploadImageEvent(
      context: mockContext,
      img: File('path/to/image'),
    )),
    expect: () => [
      RegisterState(isLoading: true, isSuccess: false),
      RegisterState(isLoading: false, isSuccess: true),
    ],
    verify: (_) {
      verify(() => mockUploadImageUsecase.call(any())).called(1);
    },
  );

  // Test case for failed image upload
  blocTest<RegisterBloc, RegisterState>(
    'emits [loading, failure] when image upload fails',
    build: () {
      when(() => mockUploadImageUsecase.call(any())).thenAnswer(
          (_) async => Left(Failure(message: 'Image upload failed')));

      return registerBloc;
    },
    act: (bloc) => bloc.add(UploadImageEvent(
      context: mockContext,
      img: File('path/to/image'),
    )),
    expect: () => [
      RegisterState(isLoading: true, isSuccess: false),
      RegisterState(isLoading: false, isSuccess: false),
    ],
    verify: (_) {
      verify(() => mockUploadImageUsecase.call(any())).called(1);
    },
  );
}

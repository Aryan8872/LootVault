import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/auth/domain/use_case/get_user_data_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_event.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_state.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes with proper implementation
class MockUpdateUserUsecase extends Mock implements UpdateUserUsecase {}

class MockGetUserDataUsecase extends Mock implements GetUserDataUsecase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

class MockFile extends Mock implements File {}

// Create a concrete mock BuildContext that provides a non-null widget
class MockBuildContext extends Mock implements BuildContext {
  @override
  Widget get widget => const SizedBox(); // Provide a non-null widget
}

void main() {
  late UserBloc userBloc;
  late MockUpdateUserUsecase mockUpdateUserUsecase;
  late MockGetUserDataUsecase mockGetUserDataUsecase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late MockBuildContext mockContext;
  late MockFile mockFile;

  setUpAll(() {
    // Register fallback values for custom types
    registerFallbackValue(const UpdateUserParams(
      userId: 'dummyUserId',
      fullName: 'dummyFullName',
      email: 'dummyEmail',
      username: 'dummyUsername',
      phoneNo: 'dummyPhoneNo',
      password: 'dummyPassword',
      image: 'dummyImage',
    ));

    registerFallbackValue(GetUserParams(userId: 'dummyUserId'));

    registerFallbackValue(UploadImageParams(image: File('dummyPath')));
  });

  setUp(() {
    mockUpdateUserUsecase = MockUpdateUserUsecase();
    mockGetUserDataUsecase = MockGetUserDataUsecase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    mockContext = MockBuildContext();
    mockFile = MockFile();

    userBloc = UserBloc(
      updateUserUsecase: mockUpdateUserUsecase,
      getUserDataUsecase: mockGetUserDataUsecase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  tearDown(() {
    userBloc.close();
  });

  // Test for UpdateUser event
  blocTest<UserBloc, UserState>(
    'emits [loading, success] when UpdateUser event is added and update is successful',
    build: () {
      when(() => mockUpdateUserUsecase.call(any()))
          .thenAnswer((_) async => const Right(AuthEntity(
                userId: '123',
                username: 'johndoe',
                fullName: 'John Doe',
                email: 'john.doe@example.com',
                phoneNo: '1234567890',
                password: 'password',
                image: 'image_url',
              )));
      return userBloc;
    },
    act: (bloc) => bloc.add(UpdateUser(
      context: mockContext,
      userId: '123',
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      userName: 'johndoe',
      phoneNo: '1234567890',
      password: 'password',
      image: 'image_url',
    )),
    expect: () => [
      const UserState(
        isLoading: true,
        isSuccess: false,
        userId: '',
        username: '',
        fullName: '',
        email: '',
        phoneNo: '',
        password: '',
        image: '',
        profileUpdated: false, // Match the default constructor
      ),
      const UserState(
        isLoading: false,
        isSuccess: true,
        profileUpdated: true,
        userId: '123',
        username: 'johndoe',
        fullName: 'John Doe',
        email: 'john.doe@example.com',
        phoneNo: '1234567890',
        password: 'password',
        image: 'image_url',
      ),
    ],
    verify: (_) {
      verify(() => mockUpdateUserUsecase.call(any())).called(1);
    },
  );

  // Test for GetUserData event
  blocTest<UserBloc, UserState>(
    'emits [loading, success] when GetUserData event is added and data is fetched successfully',
    build: () {
      when(() => mockGetUserDataUsecase.call(any()))
          .thenAnswer((_) async => const Right(AuthEntity(
                userId: '123',
                username: 'johndoe',
                fullName: 'John Doe',
                email: 'john.doe@example.com',
                phoneNo: '1234567890',
                password: 'password',
                image: 'image_url',
              )));
      return userBloc;
    },
    act: (bloc) => bloc.add(GetUserData(userId: '123', context: mockContext)),
    expect: () => [
      const UserState(
        isLoading: true,
        isSuccess: false,
        userId: '',
        username: '',
        fullName: '',
        email: '',
        phoneNo: '',
        password: '',
      ),
      const UserState(
        isLoading: false,
        isSuccess: true,
        userId: '123',
        username: 'johndoe',
        fullName: 'John Doe',
        email: 'john.doe@example.com',
        phoneNo: '1234567890',
        password: 'password',
        image: 'image_url',
      ),
    ],
    verify: (_) {
      verify(() => mockGetUserDataUsecase.call(any())).called(1);
    },
  );

 
blocTest<UserBloc, UserState>(
  'emits [loading, success] when UploadImageEvent event is added and image upload is successful',
  build: () {
    when(() => mockFile.path).thenReturn("mock_image_path.jpg"); // Ensure non-null file path
    when(() => mockUploadImageUsecase.call(any()))
        .thenAnswer((_) async => const Right(true));
    return userBloc;
  },
  act: (bloc) => bloc.add(UploadImageEvent(
    context: mockContext,
    img: mockFile,
  )),
  expect: () => [
    const UserState(
      isLoading: true,
      isSuccess: false,
      userId: '',
      username: '',
      fullName: '',
      email: '',
      phoneNo: '',
      password: '',
      image: '', // Updated: Align with Bloc logic, should be empty initially
      profileUpdated: false,
    ),
    const UserState(
      isLoading: false,
      isSuccess: true,
      userId: '',
      username: '',
      fullName: '',
      email: '',
      phoneNo: '',
      password: '',
      image: 'mock_image_path.jpg', // Updated: Ensure image path is assigned
      profileUpdated: false,
    ),
  ],
  verify: (_) {
    verify(() => mockUploadImageUsecase.call(any())).called(1);
  },
);

}

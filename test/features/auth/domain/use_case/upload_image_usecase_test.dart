import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

class MockFile extends Mock implements File {}

void main() {
  late MockAuthRepository repository;
  late UploadImageUsecase usecase;
  late MockFile mockFile; 

  setUpAll(() {
    registerFallbackValue(MockFile());
  });

  setUp(() {
    repository = MockAuthRepository();
    usecase = UploadImageUsecase(repository: repository);
    mockFile = MockFile(); 
  });

  test('should upload image successfully', () async {

    when(() => repository.uploadProfilePicture(any())).thenAnswer(
      (_) async => const Right("uploaded_image_url"),
    );

    final params = UploadImageParams(image: mockFile);
    final result = await usecase(params);

    expect(result, const Right("uploaded_image_url"));
    verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return ApiFailure when image upload fails', () async {

    final failure = ApiFailure(message: "Image upload failed");
    when(() => repository.uploadProfilePicture(any())).thenAnswer(
      (_) async => Left(failure),
    );

    final params = UploadImageParams(image: mockFile);
    final result = await usecase(params);

    expect(result, Left(failure));
    verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });
}

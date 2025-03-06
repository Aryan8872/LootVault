import 'package:flutter/material.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterUserUsecase extends Mock implements RegisterUserUsecase {}
class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}
class MockBuildContext extends Mock implements BuildContext {}
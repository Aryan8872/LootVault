import 'package:mocktail/mocktail.dart';
import 'package:loot_vault/features/auth/domain/use_case/get_user_data_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';

class MockUpdateUserUsecase extends Mock implements UpdateUserUsecase {}
class MockGetUserDataUsecase extends Mock implements GetUserDataUsecase {}
class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}
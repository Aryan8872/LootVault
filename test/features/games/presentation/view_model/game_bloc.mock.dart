import 'package:flutter/material.dart';
import 'package:loot_vault/features/games/domain/use_case/create_game_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/get_all_platform_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/getallGames_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/getall_categories_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/uploadGame_image_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateGameUseCase extends Mock implements CreateGameUsecase {}
class MockGetAllGamesUseCase extends Mock implements GetallgamesUsecase {}
class MockGetAllCategoriesUseCase extends Mock implements GetallCategoriesUsecase {}
class MockGetAllPlatformUseCase extends Mock implements GetallGamePlatformUsecase {}
class MockUploadGameImageUseCase extends Mock implements UploadGameImageUsecase {}
class MockBuildContext extends Mock implements BuildContext {}
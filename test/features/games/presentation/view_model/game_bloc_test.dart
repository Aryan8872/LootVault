import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/games/domain/use_case/create_game_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/uploadGame_image_usecase.dart';
import 'package:loot_vault/features/games/presentation/view_model/game_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'game_bloc.mock.dart';

// Mock Classes

void main() {
  late GameBloc gameBloc;
  late MockCreateGameUseCase mockCreateGameUseCase;
  late MockGetAllGamesUseCase mockGetAllGamesUseCase;
  late MockGetAllCategoriesUseCase mockGetAllCategoriesUseCase;
  late MockGetAllPlatformUseCase mockGetAllPlatformUseCase;
  late MockUploadGameImageUseCase mockUploadGameImageUseCase;
  late MockBuildContext mockContext;

  setUpAll(() {
    registerFallbackValue(const CreateGameParams(
      gameName: 'Test Game',
      category: 'Action',
      gameDescription: 'Test Description',
      gameImagePath: 'path/to/image',
      gamePlatform: 'PC',
      gamePrice: 59.99,
    ));
    registerFallbackValue(UploadGameImageParams(image: File('path/to/image')));
  });

  setUp(() {
    mockCreateGameUseCase = MockCreateGameUseCase();
    mockGetAllGamesUseCase = MockGetAllGamesUseCase();
    mockGetAllCategoriesUseCase = MockGetAllCategoriesUseCase();
    mockGetAllPlatformUseCase = MockGetAllPlatformUseCase();
    mockUploadGameImageUseCase = MockUploadGameImageUseCase();
    mockContext = MockBuildContext();

    gameBloc = GameBloc(
      getallCategoriesUsecase: mockGetAllCategoriesUseCase,
      createGameUseCase: mockCreateGameUseCase,
      getAllGamesUseCase: mockGetAllGamesUseCase,
      getallPlatformUseCase: mockGetAllPlatformUseCase,
      uploadImageUsecase: mockUploadGameImageUseCase,
    );
  });

  tearDown(() {
    gameBloc.close();
  });

  // Test case for loading games
  blocTest<GameBloc, GameState>(
    'emits [loading, games] when LoadGames event is added',
    build: () {
      when(() => mockGetAllGamesUseCase.call()).thenAnswer((_) async =>
          const Right([GameEntity(
            gameId: "1",
            gameName: 'Game 1',
            gamePlatform: 'PC',
            gameDescription: 'Description',
            gameImagePath: 'path/to/image',
            gamePrice: 59.99,
            category: 'Action'
          )]));

      return gameBloc;
    },
    act: (bloc) => bloc.add(LoadGames()),
    expect: () => [
      const GameState(isLoading: true, games: [], categories: [], platform: []),
      const GameState(
          isLoading: false, 
          games: [
            GameEntity(
              gameId: "1",
              gameName: 'Game 1',
              gamePlatform: 'PC',
              gameDescription: 'Description',
              gameImagePath: 'path/to/image',
              gamePrice: 59.99,
              category: 'Action'
            )
          ],
          categories: [],
          platform: []),
    ],
    verify: (_) {
      verify(() => mockGetAllGamesUseCase.call()).called(1);
    },
  );

  // Test case for adding a game
  blocTest<GameBloc, GameState>(
    'emits [loading, success] when AddGame event is successful',
    build: () {
      when(() => mockCreateGameUseCase.call(any()))
          .thenAnswer((_) async => const Right(null)); // Simulating success

      return gameBloc;
    },
    act: (bloc) => bloc.add(AddGame(
      gameName: 'Test Game',
      context: mockContext,
      gameDescription: 'Test Game Description',
      gameImagePath: 'path/to/image',
      category: 'Action',
      gamePrice: 59.99,
      gamePlatform: 'PC',
    )),
    expect: () => [
      const GameState(isLoading: true, games: [], categories: [], platform: []),
      const GameState(
          isLoading: false, games: [], categories: [], platform: []),
    ],
    verify: (_) {
      verify(() => mockCreateGameUseCase.call(any())).called(1);
    },
  );

  // Test case for loading categories
  blocTest<GameBloc, GameState>(
    'emits [loading, categories] when LoadCategories event is added',
    build: () {
      when(() => mockGetAllCategoriesUseCase.call()).thenAnswer((_) async =>
          const Right(
              [GameCategoryEntity(categoryId: "1", categoryName: 'Action')]));

      return gameBloc;
    },
    act: (bloc) => bloc.add(LoadCategories()),
    expect: () => [
      const GameState(isLoading: true, games: [], categories: [], platform: []),
      const GameState(
          games: [],
          isLoading: false,
          categories: [
            GameCategoryEntity(categoryId: "1", categoryName: 'Action')
          ],
          platform: []),
    ],
    verify: (_) {
      verify(() => mockGetAllCategoriesUseCase.call()).called(1);
    },
  );

  // Test case for loading platforms
  blocTest<GameBloc, GameState>(
    'emits [loading, platforms] when LoadPlatform event is added',
    build: () {
      when(() => mockGetAllPlatformUseCase.call()).thenAnswer((_) async =>
          const Right(
              [GamePlatformEntity(categoryId: "1", platformName: 'PC')]));

      return gameBloc;
    },
    act: (bloc) => bloc.add(LoadPlatform()),
    expect: () => [
      const GameState(isLoading: true, platform: [], games: [], categories: []),
      const GameState(
          games: [],
          isLoading: false,
          platform: [GamePlatformEntity(categoryId: "1", platformName: 'PC')],
          categories: []),
    ],
    verify: (_) {
      verify(() => mockGetAllPlatformUseCase.call()).called(1);
    },
  );

  // Test case for uploading a game image
  blocTest<GameBloc, GameState>(
    'emits [loading, image uploaded] when UploadGameImage event is successful',
    build: () {
      when(() => mockUploadGameImageUseCase.call(any()))
          .thenAnswer((_) async => const Right('image_uploaded.png'));

      return gameBloc;
    },
    act: (bloc) => bloc.add(UploadGameImage(
      file: File('path/to/image'),
      context: mockContext,
    )),
    expect: () => [
      const GameState(isLoading: true, games: [], categories: [], platform: []),
      const GameState(
          isLoading: false,
          games: [],
          categories: [],
          platform: [],
          imageName: 'image_uploaded.png'),
    ],
    verify: (_) {
      verify(() => mockUploadGameImageUseCase.call(any())).called(1);
    },
  );
}

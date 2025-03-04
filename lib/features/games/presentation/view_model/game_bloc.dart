import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';
import 'package:loot_vault/features/games/domain/use_case/create_game_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/get_all_platform_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/getallGames_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/getall_categories_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/uploadGame_image_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final CreateGameUsecase _createGameUseCase;
  final GetallgamesUsecase _getAllGamesUseCase;
  final GetallGamePlatformUsecase _getallPlatformUsecase;
  final GetallCategoriesUsecase _getallCategoriesUsecase;
  final UploadGameImageUsecase _uploadImageUsecase;

  GameBloc({
    required GetallCategoriesUsecase getallCategoriesUsecase,
    required CreateGameUsecase createGameUseCase,
    required GetallgamesUsecase getAllGamesUseCase,
    required GetallGamePlatformUsecase getallPlatformUseCase,
    required UploadGameImageUsecase uploadImageUsecase,
  })  : _createGameUseCase = createGameUseCase,
        _getAllGamesUseCase = getAllGamesUseCase,
        _getallCategoriesUsecase = getallCategoriesUsecase,
        _getallPlatformUsecase = getallPlatformUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(GameState.initial()) {
    on<AddGame>(_onAddGame);
    on<LoadGames>(_onLoadGames);
    on<LoadCategories>(_onLoadGameCategories);
    on<UploadGameImage>(_onLoadImage);
    on<LoadPlatform>(_onLoadGamePlatorm);

    // Call this event whenever the bloc is created to load the batches
    add(LoadCategories());
    add(LoadPlatform());
  }

  Future<void> _onLoadGames(LoadGames event, Emitter<GameState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllGamesUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (games) => emit(state.copyWith(isLoading: false, games: games)),
    );
  }

  Future<void> _onAddGame(AddGame event, Emitter<GameState> emit) async {
    emit(state.copyWith(isLoading: true));
    print("state ko ${state.imageName}");
    final result = await _createGameUseCase.call(CreateGameParams(
        gameName: event.gameName,
        category: event.category,
        gameDescription: event.gameDescription,
        gameImagePath: event.gameImagePath,
        gamePlatform :event.gamePlatform,
        gamePrice: event.gamePrice));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        showMySnackBar(context: event.context, message: "Game added successfully");
        add(LoadGames());
      },
    );
  }

  Future<void> _onLoadGamePlatorm(
      LoadPlatform event, Emitter<GameState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getallPlatformUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) {
        emit(state.copyWith(
            isLoading: false,
            platform: categories));
      },
    );
  }

  Future<void> _onLoadGameCategories(
      LoadCategories event, Emitter<GameState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getallCategoriesUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) {
        print("bloc ko event ma $categories");
        emit(state.copyWith(isLoading: false, categories: categories));
      },
    );
  }

  void _onLoadImage(UploadGameImage event, Emitter<GameState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await _uploadImageUsecase.call(
        UploadGameImageParams(image: event.file),
      );

      result.fold(
        (l) {
          print("Image Upload Failed: ${l.message}"); // ✅ Debug error
          emit(state.copyWith(isLoading: false, error: l.message));
        },
        (r) {
          print("Image Uploaded Successfully: $r"); // ✅ Debug success
          emit(state.copyWith(
              isLoading: false, imageName: r)); // ✅ Store image name
        },
      );
    } catch (e) {
      print("Image Upload Failed: $e"); // Log the full error
    }
  }

  // Future<void> _onDeleteBatch(
  //     DeleteBatch event, Emitter<BatchState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _deleteBatchUsecase
  //       .call(DeleteBatchParams(batchId: event.batchId));
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (batches) {
  //       emit(state.copyWith(isLoading: false, error: null));
  //       add(LoadBatches());
  //     },
  //   );
  // }
}

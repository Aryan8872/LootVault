import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';
import 'package:loot_vault/features/skins/domain/use_case/create_skins_usecase.dart';
import 'package:loot_vault/features/skins/domain/use_case/getall_categories_usecase.dart';

import 'package:loot_vault/features/skins/domain/use_case/getall_skins_usecase.dart';
import 'package:loot_vault/features/skins/domain/use_case/upload_skin_image_usecase.dart';

part 'skin_event.dart';
part 'skin_state.dart';

class SkinBloc extends Bloc<SkinEvent, SkinState> {
  final CreateskinUsecase _createskinUseCase;
  final GetallskinsUsecase _getAllskinsUseCase;
  final GetallCategoriesUsecase _getallCategoriesUsecase;
  final UploadskinImageUsecase _uploadImageUsecase;

  SkinBloc({
    required GetallCategoriesUsecase getallCategoriesUsecase,
    required CreateskinUsecase createskinUseCase,
    required GetallskinsUsecase getAllskinsUseCase,
    required UploadskinImageUsecase uploadImageUsecase,
  })  : _createskinUseCase = createskinUseCase,
        _getAllskinsUseCase = getAllskinsUseCase,
        _getallCategoriesUsecase = getallCategoriesUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        super(SkinState.initial()) {
    on<Addskin>(_onAddskin);
    on<Loadskins>(_onLoadskins);
    on<LoadCategories>(_onLoadskinCategories);
    on<UploadskinImage>(_onLoadImage);

    // Call this event whenever the bloc is created to load the batches
    add(LoadCategories());
    add(Loadskins());
  }

  Future<void> _onLoadskins(Loadskins event, Emitter<SkinState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllskinsUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (skins) => emit(state.copyWith(isLoading: false, skins: skins)),
    );
  }

  Future<void> _onAddskin(Addskin event, Emitter<SkinState> emit) async {
    emit(state.copyWith(isLoading: true));
    print("state ko ${state.imageName}");
    final result = await _createskinUseCase.call(CreateSkinParams(
        skinName: event.skinName,
        category: event.category,
        skinDescription: event.skinDescription,
        skinPlatform: event.skinPlatform,
        skinImagePath: event.skinImagePath,
        skinPrice: event.skinPrice));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(Loadskins());
      },
    );
  }

  Future<void> _onLoadskinCategories(
      LoadCategories event, Emitter<SkinState> emit) async {
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

  void _onLoadImage(UploadskinImage event, Emitter<SkinState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await _uploadImageUsecase.call(
        UploadskinImageParams(image: event.file),
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

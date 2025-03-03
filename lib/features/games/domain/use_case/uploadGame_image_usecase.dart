import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';

class UploadGameImageParams extends Equatable {
  final File image;

  const UploadGameImageParams({required this.image});

  //intial constructor
  const UploadGameImageParams.initial({required this.image});

  @override
  List<Object?> get props => [image];
}

class UploadGameImageUsecase
    implements UsecaseWithParams<void, UploadGameImageParams> {
  final IGameRepository repository;

  UploadGameImageUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UploadGameImageParams params) {
    print("usecase ${params.image}");
    return repository.uploadGamePicture(params.image);
  }
}

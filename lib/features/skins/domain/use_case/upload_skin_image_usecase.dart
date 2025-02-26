import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/skins/domain/repository/skin_repository.dart';

class UploadskinImageParams extends Equatable {
  final File image;

  const UploadskinImageParams({required this.image});

  //intial constructor
  const UploadskinImageParams.initial({ required this.image});

  @override
  List<Object?> get props => [image];
}
class UploadskinImageUsecase implements UsecaseWithParams<void,UploadskinImageParams>{
  final ISkinRepository repository;

  UploadskinImageUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UploadskinImageParams params) {
    print("usecase ${params.image}");
    return repository.uploadSkinPicture(params.image);
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';
import 'package:loot_vault/features/skins/domain/repository/skin_repository.dart';

class CreateSkinParams extends Equatable {
  final String skinName;
  final String skinDescription;
  final String skinImagePath;
  final String category;
  final num skinPrice;
  final String skinPlatform;


  const CreateSkinParams(
      {required this.skinName,
      required this.skinDescription,
      required this.skinPrice,
      required this.category,
      required this.skinPlatform,
      required this.skinImagePath});

  const CreateSkinParams.initial()
      : skinName = '',
        skinDescription = '',
        skinPrice = 0,
        category = '',
        skinPlatform = '',
        skinImagePath = '';

  @override
  List<Object?> get props =>
      [skinName, skinDescription,skinPlatform, skinPrice, category, skinImagePath];
}

class CreateskinUsecase
    implements UsecaseWithParams<void, CreateSkinParams> {
  final ISkinRepository skinRepository;

  CreateskinUsecase({required this.skinRepository});

  @override
  Future<Either<Failure, void>> call(CreateSkinParams params) {
    final skinEntity = SkinEntity(
        skinName: params.skinName,
        category: params.category,
        skinPlatform: params.skinPlatform,
        skinDescription: params.skinDescription,
        skinImagePath: params.skinImagePath,
        skinPrice: params.skinPrice,
        
   );

    return skinRepository.createSkin(skinEntity);
  }
}

import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';
import 'package:loot_vault/features/skins/domain/repository/skin_repository.dart';




class GetallskinsUsecase implements UsecaseWithoutParams<List<SkinEntity>>{
  final ISkinRepository skinRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetallskinsUsecase({required this.skinRepository, required this.tokenSharedPrefs});
  
  @override
  Future<Either<Failure, List<SkinEntity>>> call() {
    // TODO: implement call
    return skinRepository.getAllSkins();
  }




  
}
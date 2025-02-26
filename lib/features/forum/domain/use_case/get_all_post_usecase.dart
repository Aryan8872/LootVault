import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class GetAllPostUsecase implements UsecaseWithoutParams<dynamic>{
  final IForumRepository repository;

  GetAllPostUsecase({required this.repository});
  @override
  Future<Either<Failure, dynamic>> call() async {
    return await repository.getAllPosts();
  }
}

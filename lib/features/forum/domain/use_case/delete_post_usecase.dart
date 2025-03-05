import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class DeletePostParams {
  final String id;

  DeletePostParams({required this.id});
}

class DeletePostUsecase implements UsecaseWithParams<void, DeletePostParams> {
  final IForumRepository repository;

  DeletePostUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(DeletePostParams params) async {
    try {
      await repository.deletePost(params.id);
      return const Right(null);
    } catch (e) {
      return Left(Failure( message: e.toString()));
    }
  }
}

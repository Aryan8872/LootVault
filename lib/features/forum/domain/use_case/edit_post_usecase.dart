import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class EditPostParams {
  final String postId;
  final String content;
  final String title;

  EditPostParams(
      {required this.postId, required this.title, required this.content});
}

class EditPostUsecase implements UsecaseWithParams<void, EditPostParams> {
  final IForumRepository repository;

  EditPostUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(EditPostParams params) async {
    try {
      await repository.editPost(params.postId, params.title, params.content);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}

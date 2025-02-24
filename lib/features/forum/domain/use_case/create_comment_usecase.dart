import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class CommentParams extends Equatable {
  final String comment;
  final String postId;
  final String userId;

  const CommentParams(
      {required this.comment, required this.postId, required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CreateCommentUsecase implements UsecaseWithParams<void, CommentParams> {
  final IForumRepository repository;

  CreateCommentUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(CommentParams params) async {
    return await repository.commentPost(CommentEntity(
        commentUser: params.userId,
        content: params.comment,
        postId: params.postId));
  }
}

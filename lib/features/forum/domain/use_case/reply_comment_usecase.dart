import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class ReplyCommentParams extends Equatable {
  final String comment;
  final String postId;
  final String userId;
  final String commentId;

  const ReplyCommentParams(
      {required this.comment,
      required this.postId,
      required this.userId,
      required this.commentId});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ReplyCommentUsecase
    implements UsecaseWithParams<PostEntity, ReplyCommentParams> {
  final IForumRepository repository;

  ReplyCommentUsecase({required this.repository});

  @override
  Future<Either<Failure, PostEntity>> call(ReplyCommentParams params) async {
    try {
      final updatedPostWithComment = await repository.replyComment(
        params.postId,
        params.commentId,
        params.userId,
        params.comment,
      );

      // If the result is successful (Right), we return it as is
      return updatedPostWithComment.fold(
        (failure) {
          // In case of failure, we return the Left side with the failure
          return Left(failure);
        },
        (updatedPost) {
          // If successful, return the Right side with the PostEntity
          return Right(updatedPost);
        },
      );
    } catch (e) {
      // In case of an unexpected error, we return the failure
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

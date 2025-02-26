import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';



class GetCommentsParams extends Equatable {

  final String postId;

  const GetCommentsParams(
      {required this.postId});

  @override
  // TODO: implement props
  List<Object?> get props => [postId];
}

class GetCommentsUseCase implements UsecaseWithParams<void, GetCommentsParams> {
  final IForumRepository repositoy;

  GetCommentsUseCase({required this.repositoy});
  @override
  Future<Either<Failure,  List<CommentEntity>>> call(GetCommentsParams params) async {
    return await repositoy.getComments(params.postId);

  }
}
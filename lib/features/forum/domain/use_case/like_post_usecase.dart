import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class LikePostParams extends Equatable {
  final String userId;
  final String postId;

  const LikePostParams({required this.userId, required this.postId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LikePostUsecase implements UsecaseWithParams<void, LikePostParams> {
  final IForumRepository repository;

  LikePostUsecase({required this.repository});
  @override
  Future<Either<Failure, PostEntity>> call(LikePostParams params) async {
    try {
      final updatedPost =
          await repository.likePost(params.userId, params.postId);
      return Right(updatedPost);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

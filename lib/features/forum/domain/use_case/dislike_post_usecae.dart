import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class DislikePostParams extends Equatable {
  final String userId;
  final String postId;

  const DislikePostParams({required this.userId, required this.postId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DislikePostUsecase implements UsecaseWithParams<void, DislikePostParams> {
  final IForumRepository repository;

  DislikePostUsecase({required this.repository});
  @override
  Future<Either<Failure, PostEntity>> call(DislikePostParams params) async {
    try {
      final updatedPost =
          await repository.disLikePost(params.userId, params.postId);
      return Right(updatedPost);
    } catch (e) {
      print("api failure vitra");
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

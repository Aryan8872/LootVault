import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

abstract interface class IForumRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, void>> createPost();
  Future<Either<Failure, void>> likePost();
  Future<Either<Failure, void>> disLikePost();
  Future<Either<Failure, void>> commentPost();
  Future<Either<Failure,PostEntity>>getPostDetails();
}

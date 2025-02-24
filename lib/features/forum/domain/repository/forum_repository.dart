import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

abstract interface class IForumRepository {
  Future<Either<Failure, dynamic>> getAllPosts({int page, int limit});
  Future<Either<Failure, void>> createPost(PostEntity entity);
  Future<PostEntity> likePost(String userId,String postId);
  Future<PostEntity> disLikePost(String userId,String postId);
  Future<Either<Failure, void>> commentPost(CommentEntity entity);
  Future<Either<Failure,PostEntity>>getPostDetails(String postId);
}

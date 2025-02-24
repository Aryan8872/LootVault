import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class ForumLocalRepository implements IForumRepository {
  @override
  Future<Either<Failure, void>> commentPost(CommentEntity entity) {
    // TODO: implement commentPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> createPost(PostEntity entity) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> disLikePost(String userId,String postId) {
    // TODO: implement disLikePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostEntity>> getPostDetails(String postId) {
    // TODO: implement getPostDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> likePost(String userId,String postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }
 
}
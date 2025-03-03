import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/data/data_source/local_data_source/forum_local_data_source.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class ForumLocalRepository implements IForumRepository {
  final ForumLocalDataSource localDataSource;

  ForumLocalRepository({required this.localDataSource});

  @override
  Future<Either<Failure, void>> commentPost(CommentEntity entity) {
    // TODO: implement commentPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> createPost(PostEntity entity) async {
    try {
      final posts = await localDataSource.createPost(entity);
      print("local repo vitra ko after calling data sourc");
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try {
      final posts = await localDataSource.getAllPosts();
      return Right(posts);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostDetails(String postId) {
    // TODO: implement getPostDetails
    throw UnimplementedError();
  }

  @override
  Future<PostEntity> disLikePost(String userId, String postId) {
    // TODO: implement disLikePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(String postId) {
    // TODO: implement getComments
    throw UnimplementedError();
  }

  @override
  Future<PostEntity> likePost(String userId, String postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostEntity>> replyComment(
      String postId, String commentId, String userId, String reply) {
    // TODO: implement replyComment
    throw UnimplementedError();
  }
}

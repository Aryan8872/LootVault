import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/data/data_source/remote_data_source/forum_remote_data_source.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class ForumRemoteRepository implements IForumRepository {
  final ForumRemoteDataSource remoteDataSource;

  ForumRemoteRepository({required this.remoteDataSource});
  @override
  Future<Either<Failure, void>> commentPost(CommentEntity entity) async {
    try {
      await remoteDataSource.commentPost(entity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      String postId) async {
    try {
      final comments = await remoteDataSource.getComments(postId);
      return Right(comments);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createPost(PostEntity entity) async {
    try {
      await remoteDataSource.createPost(entity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<PostEntity> disLikePost(String userId, String postId) async {
    try {
      final dislikedpost = await remoteDataSource.disLikePost(userId, postId);
      print(dislikedpost);
      return dislikedpost.toEntity();
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostDetails(String postId) {
    // TODO: implement getPostDetails
    throw UnimplementedError();
  }

  @override
  Future<PostEntity> likePost(String userId, String postId) async {
    try {
      final likedPost = await remoteDataSource.likePost(userId, postId);
      return likedPost.toEntity();
    } catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }

  @override
  Future<Either<Failure, dynamic>> getAllPosts() async {
    try {
      final posts = await remoteDataSource.getAllPosts();
      return Right(posts);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> replyComment(
      String postId, String commentId, String userId, String reply) async {
    try {
      final updatedPost =
          await remoteDataSource.replyComment(postId, commentId, userId, reply);
      return Right(updatedPost.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    try {
      await remoteDataSource.deletePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editPost(
      String postId, String title, String content) async {
    try {
      await remoteDataSource.editPost(postId, title, content);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostById(String postId) async {
    try {
      final post = await remoteDataSource.getPostById(postId);
      print('remote reposioty ko post ${post}');
      final entity = PostEntity(
        postId: post['postId'] ?? '',
        title: post['title'] ?? '',
        content: post['content'] ?? '',
      );
      return Right(entity);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

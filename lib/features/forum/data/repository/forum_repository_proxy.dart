import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/common/internet_checker/connectivity_listener.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/forum/data/repository/forum_local_repository.dart';
import 'package:loot_vault/features/forum/data/repository/forum_remote_repository.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';

class ForumRepositoryProxy implements IForumRepository {
  final ConnectivityListener connectivityListener;
  final ForumRemoteRepository remoteRepository;
  final ForumLocalRepository localRepository;

  ForumRepositoryProxy({
    required this.connectivityListener,
    required this.remoteRepository,
    required this.localRepository,
  });

  @override
  Future<Either<Failure, void>> commentPost(CommentEntity entity) {
    // TODO: implement commentPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> createPost(PostEntity entity) async {
    if (await connectivityListener.isConnected) {
      // ✅ Fetch latest status
      try {
        print("Connected to the internet");
        return await remoteRepository.createPost(entity);
      } catch (e) {
        print("Remote call failed, falling back to local storage");
        return await localRepository.createPost(entity);
      }
    } else {
      print("No internet, saving post locally");
      return await localRepository.createPost(entity);
    }
  }

  @override
  Future<PostEntity> disLikePost(String userId, String postId) {
    // TODO: implement disLikePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> getAllPosts() async {
    if (await connectivityListener.isConnected) {
      try {
        // Fetch data from the remote repository
        final result = await remoteRepository.getAllPosts();
        // Save the data to the local repository for offline use
        // await localRepository.createPost();
        return result;
      } catch (e) {
        // If the remote call fails, fall back to the local repository
        return await localRepository.getAllPosts();
      }
    } else {
      // No internet, fetch data from the local repository
      return await localRepository.getAllPosts();
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(String postId) {
    // TODO: implement getComments
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostEntity>> getPostDetails(String postId) {
    // TODO: implement getPostDetails
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

@override
Future<Either<Failure, List<CommentEntity>>> getComments(String postId) {
  // TODO: implement getComments
  throw UnimplementedError();
}

@override
Future<Either<Failure, PostEntity>> getPostDetails(String postId) {
  // TODO: implement getPostDetails
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

  // @override
  // Future<Result> getAllPosts() async {
  //   final isConnected = await internetChecker.isConnected();
  //   if (isConnected) {
  //     try {
  //       // Fetch data from the remote repository
  //       final result = await remoteRepository.getAllPosts();
  //       // Save the data to the local repository for offline use
  //       await localRepository.savePosts(result);
  //       return result;
  //     } catch (e) {
  //       // If the remote call fails, fall back to the local repository
  //       return await localRepository.getAllPosts();
  //     }
  //   } else {
  //     // No internet, fetch data from the local repository
  //     return await localRepository.getAllPosts();
  //   }
  // }


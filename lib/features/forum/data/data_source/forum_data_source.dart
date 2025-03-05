import 'package:dartz/dartz.dart';
import 'package:loot_vault/features/forum/data/model/post_api_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

abstract interface class IForumDataSource {
  Future<List<PostEntity>>  getAllPosts();
  Future<String> createPost(PostEntity entity);
  Future<PostApiModel> likePost(String userId,String postId);
  Future<PostApiModel> disLikePost(String userId,String postId);
  Future<String> commentPost(CommentEntity entity);
  Future<void> getPostDetails(String postId);
  Future<PostApiModel> replyComment(String postId, String commentId, String userId, String reply);
  Future<List<CommentEntity>>getComments(String postId);
  Future<void> deletePost(String postId);
  Future<void> editPost(String postId, String title, String content);
  
  Future<Map<String, String?>> getPostById(String postId) ;
}

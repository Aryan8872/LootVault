import 'package:loot_vault/features/forum/data/model/post_api_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

abstract interface class IForumDataSource {
  Future<Map<String, dynamic>>  getAllPosts();
  Future<String> createPost(PostEntity entity);
  Future<PostApiModel> likePost(String userId,String postId);
  Future<PostApiModel> disLikePost(String userId,String postId);
  Future<String> commentPost(CommentEntity entity);
  Future<void> getPostDetails(String postId);
}

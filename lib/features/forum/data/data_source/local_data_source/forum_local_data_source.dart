import 'package:loot_vault/core/network/hive_service.dart';
import 'package:loot_vault/features/forum/data/data_source/forum_data_source.dart';
import 'package:loot_vault/features/forum/data/model/post_api_model.dart';
import 'package:loot_vault/features/forum/data/model/post_hive_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

class ForumLocalDataSource implements IForumDataSource {
  final HiveService hiveService;

  ForumLocalDataSource({required this.hiveService});

  @override
  Future<String> commentPost(CommentEntity entity) {
    // TODO: implement commentPost
    throw UnimplementedError();
  }

  @override
  Future<String> createPost(PostEntity entity) async {
    try {
      print("hove ko local dat source ko create vitra");
      print(entity);
      var userModel = PostHiveModel.fromEntity(entity);
      print("user hive model inside data source ${userModel}");
      await hiveService.createPost(userModel);
      print("hive service bata ayo tala");
      return "post created";
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PostApiModel> disLikePost(String userId, String postId) {
    // TODO: implement disLikePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> getAllPosts() async {
    var data = await hiveService.getallPost();
    var lest = PostHiveModel.toEntityList(data);
    print(lest);
    return lest;
  }

  @override
  Future<List<CommentEntity>> getComments(String postId) {
    // TODO: implement getComments
    throw UnimplementedError();
  }

  @override
  Future<void> getPostDetails(String postId) {
    // TODO: implement getPostDetails
    throw UnimplementedError();
  }

  @override
  Future<PostApiModel> likePost(String userId, String postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<PostApiModel> replyComment(
      String postId, String commentId, String userId, String reply) {
    // TODO: implement replyComment
    throw UnimplementedError();
  }
}

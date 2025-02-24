import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/features/forum/data/data_source/forum_data_source.dart';
import 'package:loot_vault/features/forum/data/dto/get_all_post_dto.dart';
import 'package:loot_vault/features/forum/data/model/post_api_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

class ForumRemoteDataSource implements IForumDataSource {
  final Dio _dio;

  ForumRemoteDataSource(this._dio);

  @override
  Future<String> commentPost(CommentEntity entity) async {
    try {
      Response response = await _dio.post(
          ApiEndpoints.createComment + entity.postId!,
          data: {"content": entity.content});
      if (response.statusCode == 201) {
        return "comment created";
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> createPost(PostEntity entity) async {
    try {
      Response response = await _dio.post(ApiEndpoints.createPost, data: {
        "title": entity.title,
        "content": entity.content,
        "user": entity.postUser
      });
      if (response.statusCode == 201) {
        return "post created";
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PostApiModel> disLikePost(String userId, String postId) async {
    try {
      Response response = await _dio
          .put('${ApiEndpoints.disLikePost}$postId',  data:{ "user": { "id": userId } });
      print(response.data);
      if (response.statusCode == 200) {
        print("sucess ");
        return PostApiModel.fromJson(response.data);
      } else {
        print("no success");
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print(e);
      throw Exception("huh dio exception? $e");
    } catch (e) {
      print(e);
      print("dislike datasource ma exception");

      throw Exception(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getAllPosts(
      {int page = 1, int limit = 2}) async {
    try {
      var response = await _dio.get(
        ApiEndpoints.getAllPosts,
        queryParameters: {'page': page, 'limit': limit},
      );
      if (response.statusCode == 200) {
        GetAllPostDTO postAddDTO = GetAllPostDTO.fromJson(response.data);
        return {
          'posts': postAddDTO.posts.map((post) => post.toEntity()).toList(),
          'totalPosts': postAddDTO.total,
        };
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> getPostDetails(String postId) {
    // TODO: implement getPostDetails
    throw UnimplementedError();
  }

  @override
  Future<PostApiModel> likePost(String userId, String postId) async {
    try {
      print('Making API request to like post: $postId');
      final response = await _dio.put(
        '${ApiEndpoints.likePost}$postId',
        data: {
          "user": {"id": userId}
        },
      );

      print('API response: ${response.data}');
      print('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return PostApiModel.fromJson(response.data);
      } else {
        throw Exception('Failed to like post: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}

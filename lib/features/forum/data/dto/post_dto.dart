
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';

class PostDTO {
  final String? postId;
  final String postUser;
  final String title;
  final String content;
  final List<String>? likes;
  final List<String>? dislikes;
  final List<CommentDTO>? postComments;
  final String? createdAt;
  final String? updatedAt;

  PostDTO({
    this.postId,
    required this.postUser,
    required this.title,
    required this.content,
    this.likes,
    this.dislikes,
    this.postComments,
    this.createdAt,
    this.updatedAt,
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) {
    return PostDTO(
      postId: json['_id'] as String?,
      postUser: json['user'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      likes: (json['likes'] as List<dynamic>?)?.cast<String>(),
      dislikes: (json['dislikes'] as List<dynamic>?)?.cast<String>(),
      postComments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      postUser: postUser,
      title: title,
      content: content,
      likes: likes,
      dislikes: dislikes,
      postComments:
          postComments?.map((comment) => comment.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class CommentDTO {
  final String? commentId;
  final String commentUser;
  final String content;
  final String? postId;
  final String? createdAt;
  final String? updatedAt;

  CommentDTO({
    this.commentId,
    this.postId,
    required this.commentUser,
    required this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory CommentDTO.fromJson(Map<String, dynamic> json) {
    return CommentDTO(
      commentId: json['_id'] as String?,
      commentUser: json['user'] as String,
      content: json['content'] as String,
      postId: json['postId'] as String?, // Assuming postId is in the JSON
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      commentUser: commentUser,
      content: content,
      postId: postId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
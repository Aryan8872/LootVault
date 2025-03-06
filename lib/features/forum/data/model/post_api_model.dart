// lib/features/forum/data/models/post_api_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/forum/data/model/comment_api_model.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';


part 'post_api_model.g.dart';

@JsonSerializable()
class PostApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? postId;
  final UserApiModel user; 
  final String title;
  final String content;
  final List<String>? likes;
  final List<String>? dislikes;
  final List<CommentApiModel>? postComments;
  final String? createdAt;
  final String? updatedAt;

  const PostApiModel({
    this.postId,
    required this.user,
    required this.title,
    required this.content,
    this.likes,
    this.dislikes,
    this.postComments,
    this.createdAt,
    this.updatedAt,
  });

  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostApiModelToJson(this);

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      content: content,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt,
      dislikes: dislikes ?? const [],
      likes: likes ?? const [],
      postComments: CommentApiModel.toEntityList(postComments ?? []),
      postUser: user.id,
      postUsername:user.username
       // Map user._id to postUser
    );
  }

  factory PostApiModel.fromEntity(PostEntity entity) {
    return PostApiModel(
      postId: entity.postId,
      user: UserApiModel(
        id: entity.postUser!,
        email: '', // Placeholder, adjust if email is needed
        username: '', // Placeholder, adjust if username is needed
      ),
      content: entity.content,
      title: entity.title,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      dislikes: entity.dislikes?.map((e) => e).toList(),
      likes: entity.likes?.map((e) => e).toList(),
      postComments: CommentApiModel.fromEntityList(entity.postComments ?? []),
    );
  }

  static List<PostEntity> toEntityList(List<PostApiModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        postId,
        user,
        title,
        content,
        likes,
        dislikes,
        postComments,
        createdAt,
        updatedAt,
      ];
}

@JsonSerializable()
class UserApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String email;
  final String username;

  UserApiModel({
    required this.id,
    required this.email,
    required this.username,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);
}
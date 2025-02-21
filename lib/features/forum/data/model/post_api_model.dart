import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/auth/data/model/auth_api_model.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/forum/data/model/comment_api_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';


part 'post_api_model.g.dart';

@JsonSerializable()
class PostApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? postId;
  final AuthApiModel postUser;
  final String title;
  final String content;
  final List<AuthApiModel> likes;
  final List<AuthApiModel> dislikes;
  final List<CommentApiModel> postComments;
  final String createdAt;
  final String updatedAt;

  const PostApiModel(
      {this.postId,
      required this.postUser,
      required this.title,
      required this.content,
      required this.likes,
      required this.dislikes,
      required this.postComments,
      required this.createdAt,
      required this.updatedAt});

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
        dislikes: const [],
        likes: const[],
        postComments: CommentApiModel.toEntityList(postComments),
        postUser: postUser.toEntity());
  }

  factory PostApiModel.fromEntity(PostEntity entity) {
    return PostApiModel(
        postId: entity.postId,
        content: entity.content,
        title: entity.title,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        dislikes: AuthApiModel.fromEntityList(entity.dislikes),
        likes: AuthApiModel.fromEntityList(entity.likes),
        postComments: CommentApiModel.fromEntityList(entity.postComments),
        postUser: AuthApiModel.fromEntity(entity.postUser));
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loot_vault/app/constants/hive_table_constant.dart';
import 'package:loot_vault/features/forum/data/model/comment_hive_model.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:uuid/uuid.dart';

part 'post_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.postTableId)
class PostHiveModel extends Equatable {
  @HiveField(0)
  final String postId;
  @HiveField(1)
  final String postUser;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final List<String> likes;
  @HiveField(5)
  final List<String> dislikes;
  @HiveField(6)
  final List<CommentHiveModel> postComments;
  @HiveField(7)
  final String createdAt;
  @HiveField(8)
  final String updatedAt;

  PostHiveModel({
    String? postId,
    required this.postUser,
    required this.title,
    required this.content,
    List<String>? likes,
    List<String>? dislikes,
    List<CommentHiveModel>? postComments,
    String? createdAt,
    String? updatedAt,
  })  : postId = postId ?? const Uuid().v4(),
        likes = likes ?? [],
        dislikes = dislikes ?? [],
        postComments = postComments ?? [],
        createdAt = createdAt ?? '',
        updatedAt = updatedAt ?? '';

  const PostHiveModel.initial()
      : postId = '',
        postUser = '',
        title = '',
        content = '',
        likes = const [],
        dislikes = const [],
        postComments = const [],
        createdAt = '',
        updatedAt = '';

  /// **Factory constructor to convert `PostEntity` to `PostHiveModel`**
  factory PostHiveModel.fromEntity(PostEntity entity) {
    return PostHiveModel(
      postId: entity.postId ?? const Uuid().v4(), // Ensure postId is never null
      postUser: entity.postUser ?? '',
      title: entity.title ?? '',
      content: entity.content ?? '',
      postComments: entity.postComments != null
          ? CommentHiveModel.fromEntityList(entity.postComments!)
          : [],
      createdAt: entity.createdAt ?? '',
      updatedAt: entity.updatedAt ?? '',
      likes: entity.likes ?? [],
      dislikes: entity.dislikes ?? [],
    );
  }

  /// **Converts `PostHiveModel` to `PostEntity`**
  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      postUser: postUser,
      title: title,
      content: content,
      postComments: CommentHiveModel.toEntityList(postComments),
      createdAt: createdAt,
      updatedAt: updatedAt,
      likes: likes,
      dislikes: dislikes,
    );
  }

  /// **Convert List of `PostEntity` to List of `PostHiveModel`**
  static List<PostHiveModel> fromEntityList(List<PostEntity> entities) {
    return entities.map((e) => PostHiveModel.fromEntity(e)).toList();
  }

  /// **Convert List of `PostHiveModel` to List of `PostEntity`**
  static List<PostEntity> toEntityList(List<PostHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [postId];
}

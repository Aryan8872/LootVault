import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loot_vault/app/constants/hive_table_constant.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/forum/data/model/comment_hive_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:uuid/uuid.dart';

// dart run build_runner build -d

part 'post_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.postTableId)
class PostHiveModel extends Equatable {
  @HiveField(0)
  final String? postId;
  @HiveField(1)
  final AuthHiveModel postUser;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final List<AuthHiveModel> likes;
  @HiveField(5)
  final List<AuthHiveModel> dislikes;
  @HiveField(6)
  final List<CommentHiveModel> postComments;
  @HiveField(7)
  final String createdAt;
  @HiveField(8)
  final String updatedAt;

  PostHiveModel(
      {String? postId,
      required this.postUser,
      required this.title,
      required this.content,
      required this.likes,
      required this.dislikes,
      required this.postComments,
      required this.createdAt,
      required this.updatedAt})
      : postId = postId ?? const Uuid().v4();

  const PostHiveModel.initial():
      postId = "",
      postUser = const AuthHiveModel.initial(),
      title="",
      content="",
      likes =  const [],
      dislikes = const [],
      postComments = const[],
      createdAt="",
      updatedAt="";

  factory PostHiveModel.fromEntity(PostEntity entity) {
    return PostHiveModel(
      postId: entity.postId,
      postUser: AuthHiveModel.fromEntity(entity.postUser),
      postComments:CommentHiveModel.fromEntityList(entity.postComments) ,
      content:entity.content ,
      createdAt: entity.createdAt,
      dislikes: AuthHiveModel.fromEntitytoList(entity.dislikes),
      likes: AuthHiveModel.fromEntitytoList(entity.likes),
      title:entity.title ,
      updatedAt: entity.updatedAt
    );
  
  }
  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      likes: PostHiveModel.toEntityList(likes),
      postUser: postUser.toEntity() ,
      title: title,
      postComments: CommentHiveModel.toEntityList(postComments),
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      dislikes:PostHiveModel.toEntityList(dislikes) ,
   );
  }

  static List<AuthHiveModel> fromEntitytoList(List<AuthEntity> entities) {
    return entities.map((e) => AuthHiveModel.fromEntity(e)).toList();
  }

  static List<AuthEntity> toEntityList(List<AuthHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [postId];
}

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loot_vault/app/constants/hive_table_constant.dart';
import 'package:loot_vault/features/forum/data/model/comment_hive_model.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:uuid/uuid.dart';

// dart run build_runner build -d

part 'post_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.postTableId)
class PostHiveModel extends Equatable {
  @HiveField(0)
  final String? postId;
  @HiveField(1)
  final String postUser;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final List<String>? likes;
  @HiveField(5)
  final List<String>? dislikes;
  @HiveField(6)
  final List<CommentHiveModel>? postComments;
  @HiveField(7)
  final String? createdAt;
  @HiveField(8)
  final String? updatedAt;

  PostHiveModel(
      {String? postId,
      required this.postUser,
      required this.title,
      required this.content,
       this.likes,
       this.dislikes,
       this.postComments,
       this.createdAt,
       this.updatedAt})
      : postId = postId ?? const Uuid().v4();

  const PostHiveModel.initial():
      postId = "",
      postUser = '',
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
      postUser: entity.postUser ,
     postComments: entity.postComments != null
        ? CommentHiveModel.fromEntityList(entity.postComments!)
        : [], 
      content:entity.content ,
      createdAt: entity.createdAt??'',
      dislikes: entity.dislikes?.map((e)=>e).toList() ??[],
      likes: entity.likes?.map((e)=>e).toList() ??[],
      title:entity.title ,
      updatedAt: entity.updatedAt ??''
    );
  
  }
  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      likes: likes!.map((e)=>e).toList(),
      postUser: postUser ,
      title: title,
      postComments: CommentHiveModel.toEntityList(postComments!),
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      dislikes:dislikes!.map((e)=>e).toList(), 
   );
  }

  static List<PostHiveModel> fromEntitytoList(List<PostEntity> entities) {
    return entities.map((e) => PostHiveModel.fromEntity(e)).toList();
  }

  static List<PostEntity> toEntityList(List<PostHiveModel> entities) {
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [postId];
}

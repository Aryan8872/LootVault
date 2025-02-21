import 'package:hive_flutter/adapters.dart';
import 'package:loot_vault/app/constants/hive_table_constant.dart';
import 'package:loot_vault/features/auth/data/model/auth_hive_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: HiveTableConstant.commentTableId)
class CommentHiveModel {
  @HiveField(0)
  final String? commentId;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final AuthHiveModel commentUser;
  @HiveField(3)
  final String updatedAt;
  @HiveField(4)
  final String createdAt;

  CommentHiveModel({
    String? commentId,
    required this.content,
    required this.commentUser,
    required this.updatedAt,
    required this.createdAt,
  }) : commentId = commentId ?? const Uuid().v4();

  const CommentHiveModel.initial()
      : commentId = '',
        content = '',
        updatedAt = '',
        createdAt = '',
        commentUser = const AuthHiveModel.initial();

  factory CommentHiveModel.fromEntity(CommentEntity entity) {
    return CommentHiveModel(
        commentId: entity.commentId,
        content: entity.content,
        updatedAt: entity.updatedAt,
        createdAt: entity.createdAt,
        commentUser: AuthHiveModel.fromEntity(entity.commentUser));
  }

  // To Entity
  CommentEntity toEntity() {
    return CommentEntity(
        commentId: commentId,
        content: content,
        updatedAt: updatedAt,
        createdAt: createdAt,
        commentUser: commentUser.toEntity());
  }

    static List<CommentEntity> toEntityList(List<CommentHiveModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }
    static List<CommentHiveModel> fromEntityList(List<CommentEntity> entityList) {
    return entityList
        .map((entity) => CommentHiveModel.fromEntity(entity))
        .toList();
  }
}

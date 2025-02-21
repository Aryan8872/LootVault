import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/auth/data/model/auth_api_model.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';

part 'comment_api_model.g.dart';

@JsonSerializable()
class CommentApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? commentId;
  final String content;
  final AuthApiModel commentUser;
  final String createdAt;
  final String updatedAt;

  const CommentApiModel(
      {this.commentId,
      required this.commentUser,
      required this.content,
      required this.createdAt,
      required this.updatedAt});

  factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$CommentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);

  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      commentUser: commentUser.toEntity(),
      createdAt: createdAt,
      content: content,
      updatedAt: updatedAt,
    );
  }

  factory CommentApiModel.fromEntity(CommentEntity entity) {
    return CommentApiModel(
      commentId: entity.commentId,
      commentUser: AuthApiModel.fromEntity(entity.commentUser),
      content: entity.content,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static List<CommentEntity> toEntityList(List<CommentApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  static List<CommentApiModel> fromEntityList(List<CommentEntity> entityList) {
    return entityList
        .map((entity) => CommentApiModel.fromEntity(entity))
        .toList();
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

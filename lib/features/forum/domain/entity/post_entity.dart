import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';

class PostEntity extends Equatable {
  final String? postId;
  final AuthEntity postUser;
  final String title;
  final String content;
  final List<AuthEntity> likes;
  final List<AuthEntity> dislikes;
  final List<CommentEntity> postComments;
  final String createdAt;
  final String updatedAt;

  const PostEntity(
      { this.postId,
      required this.postUser,
      required this.title,
      required this.content,
      required this.likes,
      required this.dislikes,
      required this.postComments,
      required this.createdAt,
      required this.updatedAt});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

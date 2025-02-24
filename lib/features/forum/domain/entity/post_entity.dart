import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String postUser;
  final String title;
  final String content;
  final List<String>? likes;
  final List<String>? dislikes;
  final List<CommentEntity>? postComments;
  final String? createdAt;
  final String? updatedAt;

  const PostEntity(
      {this.postId,
      required this.postUser,
      required this.title,
      required this.content,
      this.likes,
      this.dislikes,
      this.postComments,
      this.createdAt,
      this.updatedAt});

  @override
  // TODO: implement props
  List<Object?> get props => [
        postId,
        postUser,
        title,
        content,
        likes,
        dislikes,
        postComments,
        createdAt,
        updatedAt,
      ];
}

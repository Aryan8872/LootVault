import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String? postUser;
  final String title;
  final String content;
  final List<String>? likes;
  final List<String>? dislikes;
  final List<CommentEntity>? postComments;
  final String? createdAt;
  final String? updatedAt;
  final String? postUsername;

  const PostEntity(
      {this.postId,
       this.postUser,
      required this.title,
      required this.content,
      this.likes,
      this.postUsername,
      this.dislikes,
      this.postComments,
      this.createdAt,
      this.updatedAt});

  const PostEntity.empty()
      : postId = "",
        postUser = "",
        postUsername="",
        title = "",
        content = "",
        likes = const [],
        dislikes =const  [],
        postComments = const [],
        createdAt = "",
        updatedAt = "";

  @override
  // TODO: implement props
  List<Object?> get props => [
        postId,
        postUser,
        title,
        postUsername,
        content,
        likes,
        dislikes,
        postComments,
        createdAt,
        updatedAt,
      ];
}

// interface IComment extends Document {
//     _id: Types.ObjectId;
//     user: Types.ObjectId;
//     content: string;
//     createdAt: Date;
//     updatedAt: Date;
// }

import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? commentId;
  final String commentUser;
  final String content;
  final String? postId;
  final String? createdAt;
  final String? updatedAt;
  final List<dynamic> replies; // Add replies as a list of CommentEntity

  const CommentEntity(
      {this.commentId,
      this.postId,
      required this.commentUser,
      required this.content,
      this.createdAt,
      this.replies = const[],
      this.updatedAt});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [commentId, commentUser, content, createdAt, updatedAt];
}

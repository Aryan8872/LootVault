// interface IComment extends Document {
//     _id: Types.ObjectId;
//     user: Types.ObjectId;
//     content: string;
//     createdAt: Date;
//     updatedAt: Date;
// }

import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';

class CommentEntity extends Equatable {
  final String? commentId;
  final String commentUser;
  final String content;
  final String? postId;
  final String? createdAt;
  final String? updatedAt;

  const CommentEntity(
      { this.commentId,
       this.postId,
      required this.commentUser,
      required this.content,
       this.createdAt,
       this.updatedAt});

  @override
  // TODO: implement props
  List<Object?> get props => [commentId,commentUser,content,createdAt,updatedAt];
}

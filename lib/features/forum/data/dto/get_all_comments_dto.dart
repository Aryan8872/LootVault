import 'package:json_annotation/json_annotation.dart';

import 'package:loot_vault/features/forum/data/dto/user_dto.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';

part 'get_all_comments_dto.g.dart';

@JsonSerializable()
class GetAllCommentDTO {
  @JsonKey(name: "_id")
  final String id;
  final UserDTO user;
  final String content;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> replies;

  GetAllCommentDTO({
    required this.id,
    required this.user,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.replies,
  });

  // Generate a function to convert to and from JSON
  Map<String, dynamic> toJson() => _$GetAllCommentDTOToJson(this);

  factory GetAllCommentDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCommentDTOFromJson(json);


}

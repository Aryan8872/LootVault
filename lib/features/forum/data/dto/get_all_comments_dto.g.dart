// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_comments_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCommentDTO _$GetAllCommentDTOFromJson(Map<String, dynamic> json) =>
    GetAllCommentDTO(
      id: json['_id'] as String,
      user: UserDTO.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      replies: json['replies'] as List<dynamic>,
    );

Map<String, dynamic> _$GetAllCommentDTOToJson(GetAllCommentDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'replies': instance.replies,
    };

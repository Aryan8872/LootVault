// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentApiModel _$CommentApiModelFromJson(Map<String, dynamic> json) =>
    CommentApiModel(
      commentId: json['_id'] as String?,
      commentUser: json['commentUser'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$CommentApiModelToJson(CommentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.commentId,
      'content': instance.content,
      'commentUser': instance.commentUser,
    };

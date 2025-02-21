// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) => PostApiModel(
      postId: json['_id'] as String?,
      postUser: AuthApiModel.fromJson(json['postUser'] as Map<String, dynamic>),
      title: json['title'] as String,
      content: json['content'] as String,
      likes: (json['likes'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dislikes: (json['dislikes'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      postComments: (json['postComments'] as List<dynamic>)
          .map((e) => CommentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$PostApiModelToJson(PostApiModel instance) =>
    <String, dynamic>{
      '_id': instance.postId,
      'postUser': instance.postUser,
      'title': instance.title,
      'content': instance.content,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'postComments': instance.postComments,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

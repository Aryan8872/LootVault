// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) => PostApiModel(
      postId: json['_id'] as String?,
      user: UserApiModel.fromJson(json['user'] as Map<String, dynamic>),
      title: json['title'] as String,
      content: json['content'] as String,
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      dislikes: (json['dislikes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      postComments: (json['postComments'] as List<dynamic>?)
          ?.map((e) => CommentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PostApiModelToJson(PostApiModel instance) =>
    <String, dynamic>{
      '_id': instance.postId,
      'user': instance.user,
      'title': instance.title,
      'content': instance.content,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'postComments': instance.postComments,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['_id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'username': instance.username,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPostDTO _$GetAllPostDTOFromJson(Map<String, dynamic> json) =>
    GetAllPostDTO(
      total: (json['total'] as num).toInt(),
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: (json['currentPage'] as num).toInt(),
    );

Map<String, dynamic> _$GetAllPostDTOToJson(GetAllPostDTO instance) =>
    <String, dynamic>{
      'total': instance.total,
      'posts': instance.posts,
      'currentPage': instance.currentPage,
    };

import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/forum/data/model/post_api_model.dart';

part 'get_all_post_dto.g.dart';

@JsonSerializable()
class GetAllPostDTO {
  final int total;
  @JsonKey(name: 'posts') // Map 'posts' from JSON to 'data'
  final List<PostApiModel> posts;
  final int currentPage;

  GetAllPostDTO({
    required this.total,
    required this.posts,
    required this.currentPage,
  });

  Map<String, dynamic> toJson() => _$GetAllPostDTOToJson(this);

  factory GetAllPostDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPostDTOFromJson(json);
}

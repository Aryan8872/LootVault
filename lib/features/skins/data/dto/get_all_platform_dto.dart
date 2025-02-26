import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/data/model/game_category_api_model.dart';

part 'get_all_platform_dto.g.dart';

@JsonSerializable()
class GetAllPlatformDto {
  final bool success;
  final int count;
  final List<GameCategoryApiModel> data;

  GetAllPlatformDto({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllPlatformDtoToJson(this);

  factory GetAllPlatformDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllPlatformDtoFromJson(json);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/data/model/game_category_api_model.dart';

part 'get_all_game_platform_dto.g.dart';

@JsonSerializable()
class GetAllGamePlatformDto {
  final bool success;
  final int count;
  final List<GameCategoryApiModel> data;

  GetAllGamePlatformDto({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllGamePlatformDtoToJson(this);

  factory GetAllGamePlatformDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllGamePlatformDtoFromJson(json);
}

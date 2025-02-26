import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/data/model/game_category_api_model.dart';

part 'get_all_gamecategories_dto.g.dart';

@JsonSerializable()
class GetAllGamecategoriesDto {
  final bool success;
  final int count;
  final List<GameCategoryApiModel> data;

  GetAllGamecategoriesDto({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllGamecategoriesDtoToJson(this);

  factory GetAllGamecategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllGamecategoriesDtoFromJson(json);
}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';

part 'game_category_api_model.g.dart';

@JsonSerializable()
class GameCategoryApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String categoryId;
  final String categoryName;

  const GameCategoryApiModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory GameCategoryApiModel.fromJson(Map<String, dynamic> json) =>
      _$GameCategoryApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameCategoryApiModelToJson(this);

  GameCategoryEntity toEntity() {
    return GameCategoryEntity(
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }

  factory GameCategoryApiModel.fromEntity(GameCategoryEntity entity) {
    return GameCategoryApiModel(
      categoryName: entity.categoryName,
      categoryId: entity.categoryId,
 
    );
  }
  static List<GameCategoryEntity> toEntityList(List<GameCategoryApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props =>
      [categoryId, categoryName];
}

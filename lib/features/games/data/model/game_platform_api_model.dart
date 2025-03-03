import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/games/domain/entity/platform_entity.dart';

part 'game_platform_api_model.g.dart';

@JsonSerializable()
class GamePlatformApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String platformId;
  final String platformName;

  const GamePlatformApiModel({
    required this.platformId,
    required this.platformName,
  });

  factory GamePlatformApiModel.fromJson(Map<String, dynamic> json) =>
      _$GamePlatformApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$GamePlatformApiModelToJson(this);

  GamePlatformEntity toEntity() {
    return GamePlatformEntity(
      categoryId: platformId,
      platformName: platformName,
    );
  }

  factory GamePlatformApiModel.fromEntity(GameCategoryEntity entity) {
    return GamePlatformApiModel(
      platformName: entity.categoryName,
      platformId: entity.categoryId,
 
    );
  }
  static List<GamePlatformEntity> toEntityList(List<GamePlatformApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props =>
      [platformId, platformName];
}

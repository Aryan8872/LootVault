import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/domain/entity/game_category_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/platform_entity.dart';

part 'platform_api_model.g.dart';

@JsonSerializable()
class PlatformApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String platformId;
  final String platformName;

  const PlatformApiModel({
    required this.platformId,
    required this.platformName,
  });

  factory PlatformApiModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformApiModelToJson(this);

  PlatformEntity toEntity() {
    return PlatformEntity(
      categoryId: platformId,
      platformName: platformName,
    );
  }

  factory PlatformApiModel.fromEntity(GameCategoryEntity entity) {
    return PlatformApiModel(
      platformName: entity.categoryName,
      platformId: entity.categoryId,
 
    );
  }
  static List<PlatformEntity> toEntityList(List<PlatformApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props =>
      [platformId, platformName];
}

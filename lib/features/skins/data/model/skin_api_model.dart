import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

part 'skin_api_model.g.dart';

@JsonSerializable()
class SkinApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? skinId;
  final String skinName;
  final String skinDescription;
  final String skinImagePath;
  final dynamic category;
  final num skinPrice;
  final dynamic skinPlatform;

  const SkinApiModel(
      {required this.skinId,
      required this.skinName,
      required this.skinDescription,
      required this.skinPrice,
      required this.skinPlatform,
      required this.skinImagePath,
      required this.category});

  factory SkinApiModel.fromJson(Map<String, dynamic> json) =>
      _$SkinApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkinApiModelToJson(this);

  SkinEntity toEntity(){
    return SkinEntity(
      skinId: skinId,
      skinDescription: skinDescription,
      category: category,
      skinPrice: skinPrice,
      skinImagePath: skinImagePath,
      skinPlatform: skinPlatform,
      skinName: skinName
      );
  }

  factory SkinApiModel.fromEntity(SkinEntity entity){
    return SkinApiModel(
      skinName: entity.skinName,
      skinDescription: entity.skinDescription,
      skinImagePath: entity.skinImagePath,
      skinId: entity.skinId,
      category: entity.category,
      skinPlatform: entity.skinPlatform,
      skinPrice: entity.skinPrice,
    );
  }
  static List<SkinEntity> toEntityList(List<SkinApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props =>
      [skinId, skinName,skinPlatform, skinImagePath, skinDescription, category, skinPrice];
}

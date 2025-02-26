import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/skins/data/model/skin_api_model.dart';

part 'get_all_skins_dto.g.dart';

@JsonSerializable()
class GetAllSkinsDTO {
  final bool success;
  final int count;
  final List<SkinApiModel> data;

  GetAllSkinsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllSkinsDTOToJson(this);

  factory GetAllSkinsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllSkinsDTOFromJson(json);
}
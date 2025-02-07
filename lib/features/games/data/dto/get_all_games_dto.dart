import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/data/model/game_api_model.dart';

part 'get_all_games_dto.g.dart';

@JsonSerializable()
class GetAllGameDTO {
  final bool success;
  final int count;
  final List<GameApiModel> data;

  GetAllGameDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllGameDTOToJson(this);

  factory GetAllGameDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllGameDTOFromJson(json);
}
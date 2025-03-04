import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/games/data/model/game_api_model.dart';

part 'get_all_games_dto.g.dart';

@JsonSerializable()
class GetAllGameDTO {
  final bool error; 
  final int total;
  final int page;
  final int limit;
  @JsonKey(name: 'games')
  final List<GameApiModel> games; 

  GetAllGameDTO({
    required this.error,
    required this.total,
    required this.page,
    required this.limit,
    required this.games,
  });

  Map<String, dynamic> toJson() => _$GetAllGameDTOToJson(this);

  factory GetAllGameDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllGameDTOFromJson(json);
}

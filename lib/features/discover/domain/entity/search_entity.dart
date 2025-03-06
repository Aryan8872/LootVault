import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

class SearchEntity {
   final List<GameEntity> games;
  final List<SkinEntity> skins;

  SearchEntity({required this.games, required this.skins});
}
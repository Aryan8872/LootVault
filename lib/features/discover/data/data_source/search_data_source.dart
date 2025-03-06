import 'package:loot_vault/features/games/data/model/game_api_model.dart';
import 'package:loot_vault/features/skins/data/model/skin_api_model.dart';

abstract interface class ISearchDataSource {
  Future<List<GameApiModel>> searchGames({
    required String query,
    double? minPrice,
    double? maxPrice,
    List<String>? categories,
    List<String>? platforms,
    int page,
    int limit,
    String sortBy,
    String order,
  });

  Future<List<SkinApiModel>> searchSkins({
    required String query,
    double? minPrice,
    double? maxPrice,
    List<String>? categories,
    List<String>? platforms,
    int page,
    int limit,
    String sortBy,
    String order,
  });
}

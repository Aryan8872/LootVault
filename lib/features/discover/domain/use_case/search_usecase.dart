import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/discover/data/repository/searc_remote_repository.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

class SearchParams {
  final String query;
  final double? minPrice;
  final double? maxPrice;
  final List<String>? categories;
  final List<String>? platforms;
  final String? sortBy;
  final String? order;
  final String? type;

  SearchParams({
    required this.query,
    this.minPrice,
    this.maxPrice,
    this.categories,
    this.platforms,
    this.sortBy = "gamePrice", // Default sort field
    this.order = "asc", // Default order
    this.type = "both", // Default type
  });
}

class SearchGamesAndSkinsUsecase {
  final SearchRemoteRepository repository;

  SearchGamesAndSkinsUsecase({required this.repository});

  Future<Either<Failure, SearchResults>> call(SearchParams params) async {
    return await repository.search(
      query: params.query,
      minPrice: params.minPrice,
      maxPrice: params.maxPrice,
      categories: params.categories,
      platforms: params.platforms,
      type: params.type,
    );
  }
}

class SearchResults {
  final List<GameEntity> games;
  final List<SkinEntity> skins;

  SearchResults({required this.games, required this.skins});
}
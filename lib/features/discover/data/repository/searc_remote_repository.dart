import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/discover/data/data_source/remote_data_source/search_remote_data_source.dart';
import 'package:loot_vault/features/discover/domain/repository/search_repository.dart';
import 'package:loot_vault/features/discover/domain/use_case/search_usecase.dart';
import 'package:loot_vault/features/games/data/model/game_api_model.dart';
import 'package:loot_vault/features/games/data/model/game_category_api_model.dart';
import 'package:loot_vault/features/games/data/model/game_platform_api_model.dart';
import 'package:loot_vault/features/skins/data/model/skin_api_model.dart';

class SearchRemoteRepository implements ISearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;

  SearchRemoteRepository({required SearchRemoteDataSource searchRemoteDataSource})
      : _searchRemoteDataSource = searchRemoteDataSource;

  @override
  Future<Either<Failure, SearchResults>> search({
    required String query,
    double? minPrice,
    double? maxPrice,
    List<String>? categories,
    List<String>? platforms,
    String? type,
  }) async {
    try {
      print("Making API call...");
      final response = await _searchRemoteDataSource.search(
        query: query,
        minPrice: minPrice,
        maxPrice: maxPrice,
        categories: categories,
        platforms: platforms,
        type: type,
      );

      print("repo ko response: $response");

      // Check if 'games' and 'skins' keys exist in the response
      if (!response.containsKey('games') || !response.containsKey('skins')) {
        print("Response is missing 'games' or 'skins' keys");
        return Left(Failure(message: "Invalid API response format"));
      }

      // Parse the response into SearchResults
      final games = (response['games'] as List)
          .map((gameJson) {
            print("Parsing game: $gameJson");
            // Manually parse the category and platform fields
            final category = GameCategoryApiModel.fromJson(gameJson['category'] as Map<String, dynamic>);
            final platform = GamePlatformApiModel.fromJson(gameJson['gamePlatform'] as Map<String, dynamic>);

            return GameApiModel(
              gameId: gameJson['_id'],
              gameName: gameJson['gameName'],
              gameDescription: gameJson['gameDescription'],
              gamePrice: gameJson['gamePrice'],
              gameImagePath: gameJson['gameImagePath'],
              category: category,
              gamePlatform: platform,
            );
          })
          .toList();

      final skins = (response['skins'] as List)
          .map((skinJson) {
            print("Parsing skin: $skinJson");
            // Manually parse the category and platform fields
            final category = GameCategoryApiModel.fromJson(skinJson['category'] as Map<String, dynamic>);
            final platform = GamePlatformApiModel.fromJson(skinJson['skinPlatform'] as Map<String, dynamic>);

            return SkinApiModel(
              skinId: skinJson['_id'],
              skinName: skinJson['skinName'],
              skinDescription: skinJson['skinDescription'],
              skinPrice: skinJson['skinPrice'],
              skinImagePath: skinJson['skinImagePath'],
              category: category,
              skinPlatform: platform,
            );
          })
          .toList();

      print("Games parsed: $games");
      print("Skins parsed: $skins");

      // Convert API models to entities
      final gameEntities = GameApiModel.toEntityList(games);
      final skinEntities = SkinApiModel.toEntityList(skins);

      print("after mapping gameEntities: $gameEntities");
      print("after mapping skinEntities: $skinEntities");

      return Right(SearchResults(games: gameEntities, skins: skinEntities));
    } on Failure catch (e) {
      print("Failure occurred: ${e.message}");
      return Left(e);
    } catch (e) {
      print("Exception occurred: $e");
      return Left(Failure(message: 'An error occurred: $e'));
    }
  }
}
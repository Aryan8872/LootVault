import 'package:loot_vault/features/games/data/model/game_api_model.dart';
import 'package:loot_vault/features/skins/data/model/skin_api_model.dart';

class ApiResponse {
  final bool error;
  final int total;
  final int currentPage;
  final int limit;
  final List<dynamic> games;

  ApiResponse({
    required this.error,
    required this.total,
    required this.currentPage,
    required this.limit,
    required this.games,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      error: json['error'],
      total: json['total'],
      currentPage: json['currentPage'],
      limit: json['limit'],
      games: json['games'].map((item) {
        if (item['gameName'] != null) {
          return GameApiModel.fromJson(item);
        } else {
          return SkinApiModel.fromJson(item);
        }
      }).toList(),
    );
  }
}
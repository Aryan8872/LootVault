part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<GameEntity> games;
  final bool isLoading;
  final String? error;
  final String? imageName;
  final List<GamePlatformEntity>? platform;
  final List<GameCategoryEntity> categories;

  const GameState({
    required this.games,
    required this.isLoading,
    required this.categories,
    required this.platform,
    this.imageName,
    this.error,
  });

  factory GameState.initial() {
    return const GameState(
        games: [],
        platform: [],
        categories: [],
        isLoading: false,
        imageName: null);
  }

  GameState copyWith({
    List<GameEntity>? games,
    bool? isLoading,
    String? error,
    List<GamePlatformEntity>? platform, // ✅ Ensure this matches parameter type
    String? imageName,
    List<GameCategoryEntity>? categories,
  }) {
    return GameState(
      games: games ?? this.games,
      isLoading: isLoading ?? this.isLoading,
      platform: platform ?? this.platform, // ✅ Ensure null safety
      imageName: imageName ?? this.imageName,
      categories: categories ?? this.categories,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [games, platform, isLoading, categories, error, imageName];
}

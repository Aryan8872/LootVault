part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<GameEntity> games;
  final bool isLoading;
  final String? error;
  final String? imageName;
  final List<GameCategoryEntity> categories;

  const GameState({
    required this.games,
    required this.isLoading,
    required this.categories,
    this.imageName,
    this.error,
  });

  factory GameState.initial() {
    return const GameState(
        games: [], categories: [], isLoading: false, imageName: null);
  }

  GameState copyWith(
      {List<GameEntity>? games,
      bool? isLoading,
      String? error,
      String? imageName,
      List<GameCategoryEntity>? categories}) {
    return GameState(
      games: games ?? this.games,
      isLoading: isLoading ?? this.isLoading,
      imageName: imageName ?? this.imageName,
      categories: categories ?? this.categories,
      error: error,
    );
  }

  @override
  List<Object?> get props => [games, isLoading,categories, error,imageName];
}

import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/games/domain/entity/game_entity.dart';
import 'package:loot_vault/features/skins/domain/entity/skin_entity.dart';

class SearchState extends Equatable {
  final List<GameEntity> games; // Non-nullable
  final List<SkinEntity> skins; // Non-nullable
  final bool isLoading;
  final String? error;

  const SearchState({
    this.games = const [], // Default to empty list
    this.skins = const [], // Default to empty list
    required this.isLoading,
    this.error,
  });

  factory SearchState.initial() {
    return const SearchState(
      games: [],
      skins: [],
      isLoading: false,
    );
  }

  SearchState copyWith({
    List<GameEntity>? games,
    List<SkinEntity>? skins,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      games: games ?? this.games,
      skins: skins ?? this.skins,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [games, skins, isLoading, error];
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/features/discover/domain/use_case/search_usecase.dart';
import 'package:loot_vault/features/discover/presentation/view_model/search_event.dart';
import 'package:loot_vault/features/discover/presentation/view_model/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchGamesAndSkinsUsecase _searchGamesAndSkinsUsecase;

  SearchBloc({required SearchGamesAndSkinsUsecase searchGamesAndSkinsUsecase})
      : _searchGamesAndSkinsUsecase = searchGamesAndSkinsUsecase,
        super(SearchState.initial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await _searchGamesAndSkinsUsecase.call(SearchParams(
        query: event.query,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        categories: event.categories,
        platforms: event.platforms,
        sortBy: event.sortBy ?? 'gamePrice', // Default to 'gamePrice'
        order: event.order ?? 'asc', // Default to 'asc'
        type: event.type ?? 'both', // Default to 'both'
      ));

      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message,
          ));
        },
        (searchResults) {
          emit(state.copyWith(
            isLoading: false,
            games: searchResults.games,
            skins: searchResults.skins,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
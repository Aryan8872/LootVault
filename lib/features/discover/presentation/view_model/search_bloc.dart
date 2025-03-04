import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/discover/presentation/view_model/search_event.dart';
import 'package:loot_vault/features/discover/presentation/view_model/search_state.dart';



class SearchBloc extends Bloc<SearchEvent, SearchState> {

  SearchBloc(this.searchGames) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      emit(SearchLoading());
      final result = await searchGames(event.query, event.page, event.limit);
      result.fold(
        (failure) => emit(SearchError(failure)),
        (games) => emit(SearchLoaded(games)),
      );
    });
  }
}
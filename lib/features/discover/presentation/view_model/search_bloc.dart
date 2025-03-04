import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';



class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchGames searchGames;

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
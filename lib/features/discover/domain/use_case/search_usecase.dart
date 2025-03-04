import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/discover/domain/repository/search_repository.dart';

class SearchParams extends Equatable {
  final String query;

  const SearchParams({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchUsecase implements UsecaseWithParams<List<dynamic>, SearchParams> {
  final ISearchRepository searchRepository;

  SearchUsecase({required this.searchRepository});
  @override
  Future<Either<Failure, List<dynamic>>> call(SearchParams params) async {
    return await searchRepository.searchGames(params.query);
  }
}

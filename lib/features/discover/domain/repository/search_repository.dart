import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/discover/domain/use_case/search_usecase.dart';

abstract interface class ISearchRepository {
  Future<Either<Failure, SearchResults>> search({
    required String query,
    double? minPrice,
    double? maxPrice,
    List<String>? categories,
    List<String>? platforms,
    String? type,
  });
}

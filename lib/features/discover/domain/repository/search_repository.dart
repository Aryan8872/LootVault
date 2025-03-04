import 'package:dartz/dartz.dart';

abstract interface class ISearchRepository {
  Future<Either<String, List<dynamic>>> searchGames(String query);
}
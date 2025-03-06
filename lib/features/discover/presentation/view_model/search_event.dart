

 import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class SearchQueryChanged extends SearchEvent {
  final String query;
  final double? minPrice;
  final double? maxPrice;
  final List<String>? categories;
  final List<String>? platforms;
  final String? sortBy;
  final String? order;
  final String? type;

  const SearchQueryChanged({
    required this.query,
    this.minPrice,
    this.maxPrice,
    this.categories,
    this.platforms,
    this.sortBy,
    this.order,
    this.type,
  });

  @override
  List<Object> get props => [query];
}
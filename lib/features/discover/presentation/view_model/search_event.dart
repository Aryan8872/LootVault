import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchProductEvent extends SearchEvent {
  final List<dynamic> products;

  const SearchProductEvent({required this.products});
}

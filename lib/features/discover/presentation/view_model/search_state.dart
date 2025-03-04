import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final String message;
  final List<dynamic> products;

  const SearchState({required this.message, required this.products});

  @override
  // TODO: implement props
  List<Object?> get props => [message, products];
}

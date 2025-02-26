import 'package:equatable/equatable.dart';

class GameCategoryEntity extends Equatable {
  final String categoryId;
  final String categoryName;


  const GameCategoryEntity(
      { required this.categoryId,
      required this.categoryName,
 y});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [categoryId, categoryName];
}

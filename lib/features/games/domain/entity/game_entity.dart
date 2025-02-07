import 'package:equatable/equatable.dart';

class GameEntity extends Equatable {
  final String? gameId;
  final String gameName;
  final String gameDescription;
  final String gameImagePath;
  final String category;
  final String gamePrice;

  const GameEntity(
      { this.gameId,
      required this.gameName,
      required this.gameDescription,
      required this.gameImagePath,
      required this.gamePrice,
      required this.category});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [gameId, gameName, gameDescription, gameImagePath, category,gamePrice];
}

import 'package:equatable/equatable.dart';

class GameEntity extends Equatable {
  final String? gameId;
  final String gameName;
  final String gameDescription;
  final String gameImagePath;
  final dynamic gamePlatform;
  final dynamic category;
  final num gamePrice;

  const GameEntity(
      { this.gameId,
      required this.gameName,
      required this.gamePlatform,
      required this.gameDescription,
      required this.gameImagePath,
      required this.gamePrice,
      required this.category});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [gameId, gameName, gameDescription,gamePlatform, gameImagePath, category,gamePrice];
}

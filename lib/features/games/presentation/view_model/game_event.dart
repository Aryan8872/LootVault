part of 'game_bloc.dart';

@immutable
sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

final class LoadGames extends GameEvent {}

final class LoadCategories extends GameEvent {}

final class AddGame extends GameEvent {
  final String gameName;
  final String gameDescription;
  final BuildContext context;
  final String gameImagePath;
  final String category;
  final String gamePrice;
  final String gamePlatform;

  const AddGame(
      {required this.gameName,
      required this.context,
      required this.gameDescription,
      required this.gamePlatform,
      required this.gameImagePath,
      required this.category,
      required this.gamePrice});

  @override
  List<Object> get props => [gameName];
}

final class LoadPlatform extends GameEvent {}

class UploadGameImage extends GameEvent {
  final File file;
  final BuildContext context;

  const UploadGameImage({
    required this.file,
    required this.context
  });
}
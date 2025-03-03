import 'package:equatable/equatable.dart';

class GamePlatformEntity extends Equatable {
  final String categoryId;
  final String platformName;

  const GamePlatformEntity(
      {required this.categoryId, required this.platformName, y});

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId, platformName];
}

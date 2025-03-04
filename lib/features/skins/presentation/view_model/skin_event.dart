part of 'skin_bloc.dart';

@immutable
sealed class SkinEvent extends Equatable {
  const SkinEvent();

  @override
  List<Object> get props => [];
}

final class Loadskins extends SkinEvent {}

final class LoadCategories extends SkinEvent {}
final class LoadPlatform extends SkinEvent {}


final class Addskin extends SkinEvent {
  final String skinName;
  final BuildContext context;
  final String skinDescription;
  final String skinImagePath;
  final String category;
  final num skinPrice;
  final String skinPlatform;

  const Addskin(
      {required this.skinName,
      required this.context,
      required this.skinPlatform,
      required this.skinDescription,
      required this.skinImagePath,
      required this.category,
      required this.skinPrice});

  @override
  List<Object> get props => [skinName, context,skinDescription,skinPlatform,skinImagePath,skinPrice];
}
class UploadskinImage extends SkinEvent {
  final File file;
  final BuildContext context;

  const UploadskinImage({
    required this.file,
    required this.context
  });
}
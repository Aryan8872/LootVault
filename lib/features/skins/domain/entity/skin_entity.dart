import 'package:equatable/equatable.dart';

class SkinEntity extends Equatable {
  final String? skinId;
  final String skinName;
  final String skinDescription;
  final String skinImagePath;
  final String category;
  final String skinPrice;
  final String skinPlatform;

  const SkinEntity(
      { this.skinId,
      required this.skinName,
      required this.skinDescription,
      required this.skinImagePath,
      required this.skinPrice,
      required this.skinPlatform,
      required this.category});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [skinId, skinName,skinPlatform, skinDescription, skinImagePath, category,skinPrice];
}

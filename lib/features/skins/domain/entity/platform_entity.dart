import 'package:equatable/equatable.dart';

class PlatformEntity extends Equatable {
  final String categoryId;
  final String platformName;


  const PlatformEntity(
      { required this.categoryId,
      required this.platformName,
 y});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [categoryId, platformName];
}

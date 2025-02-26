part of 'skin_bloc.dart';

class SkinState extends Equatable {
  final List<SkinEntity> skins;
  final bool isLoading;
  final String? error;
  final String? imageName;
  final List<GameCategoryEntity> categories;
  final List<PlatformEntity> platform;

  const SkinState({
    required this.skins,
    required this.isLoading,
    required this.categories,
    required this.platform,
    this.imageName,
    this.error,
  });

  factory SkinState.initial() {
    return const SkinState(
        platform: [],
        skins: [],
        categories: [],
        isLoading: false,
        imageName: null);
  }

  SkinState copyWith(
      {List<SkinEntity>? skins,
      bool? isLoading,
      String? error,
      String? imageName,
      List<GameCategoryEntity>? categories}) {
    return SkinState(
      skins: skins ?? this.skins,
      platform: platform ?? platform,
      isLoading: isLoading ?? this.isLoading,
      imageName: imageName ?? this.imageName,
      categories: categories ?? this.categories,
      error: error,
    );
  }

  @override
  List<Object?> get props => [skins, isLoading,platform, categories, error, imageName];
}

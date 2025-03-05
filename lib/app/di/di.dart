import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/internet_checker/connectivity_listener.dart';
import 'package:loot_vault/core/common/internet_checker/internet_checker.dart';
import 'package:loot_vault/core/common/internet_checker/internet_checker_impl.dart';
import 'package:loot_vault/core/network/api_service.dart';
import 'package:loot_vault/core/network/hive_service.dart';
import 'package:loot_vault/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:loot_vault/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:loot_vault/features/auth/data/repository/auth_local_repository.dart';
import 'package:loot_vault/features/auth/data/repository/auth_remote_repository.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';
import 'package:loot_vault/features/auth/domain/use_case/get_user_data_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/login_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_bloc.dart';
import 'package:loot_vault/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:loot_vault/features/cart/data/repository/cart_remote_repo.dart';
import 'package:loot_vault/features/cart/domain/repository/cart_repo.dart';
import 'package:loot_vault/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:loot_vault/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:loot_vault/features/cart/domain/usecase/get_cart_items_usecase.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:loot_vault/features/forum/data/data_source/local_data_source/forum_local_data_source.dart';
import 'package:loot_vault/features/forum/data/data_source/remote_data_source/forum_remote_data_source.dart';
import 'package:loot_vault/features/forum/data/repository/forum_local_repository.dart';
import 'package:loot_vault/features/forum/data/repository/forum_remote_repository.dart';
import 'package:loot_vault/features/forum/data/repository/forum_repository_proxy.dart';
import 'package:loot_vault/features/forum/domain/repository/forum_repository.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_comment_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/create_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/delete_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/dislike_post_usecae.dart';
import 'package:loot_vault/features/forum/domain/use_case/edit_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_all_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_comments_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/get_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/like_post_usecase.dart';
import 'package:loot_vault/features/forum/domain/use_case/reply_comment_usecase.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc.dart';
import 'package:loot_vault/features/games/data/data_source/local_data_source/game_local_data_source.dart';
import 'package:loot_vault/features/games/data/data_source/remote_data_source/game_remote_data_source.dart';
import 'package:loot_vault/features/games/data/repository/game_local_repository.dart';
import 'package:loot_vault/features/games/data/repository/game_remote_repository.dart';
import 'package:loot_vault/features/games/data/repository/game_reposittory_proxy.dart';
import 'package:loot_vault/features/games/domain/repository/game_repository.dart';
import 'package:loot_vault/features/games/domain/use_case/create_game_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/get_all_platform_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/getallGames_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/getall_categories_usecase.dart';
import 'package:loot_vault/features/games/domain/use_case/uploadGame_image_usecase.dart';
import 'package:loot_vault/features/games/presentation/view_model/game_bloc.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';
import 'package:loot_vault/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:loot_vault/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:loot_vault/features/skins/data/data_source/local_data_source/skin_local_data_source.dart';
import 'package:loot_vault/features/skins/data/data_source/remote_data_source/skin_remote_data_source.dart';
import 'package:loot_vault/features/skins/data/repository/game_local_repository.dart';
import 'package:loot_vault/features/skins/data/repository/skin_remote_repository.dart';
import 'package:loot_vault/features/skins/domain/repository/skin_repository.dart';
import 'package:loot_vault/features/skins/domain/use_case/create_skins_usecase.dart';
import 'package:loot_vault/features/skins/domain/use_case/get_all_platform_usecase.dart';
import 'package:loot_vault/features/skins/domain/use_case/getall_categories_usecase.dart';
import 'package:loot_vault/features/skins/domain/use_case/getall_skins_usecase.dart';
import 'package:loot_vault/features/skins/domain/use_case/upload_skin_image_usecase.dart';
import 'package:loot_vault/features/skins/presentation/view_model/skin_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Hive, API, and SharedPreferences
  await _initHiveService();
  await _initApiService();
  await _initSharedPrefs();

  // Register InternetChecker
// Register InternetChecker
  getIt.registerLazySingleton<IInternetChecker>(() => InternetCheckerImpl());
  getIt.registerLazySingleton<ConnectivityListener>(
      () => ConnectivityListener());

  // Initialize feature dependencies
  await _initHomeDependencies();
  await __initRegisterDependencies();
  await _initLoginDependencies();
  await _initGameDependencies();
  await _initSkinsDependencies();
  await _initOnboardingDependency();
  await _initForumDependencies();
  await _initCartDependency();
  await _initSellerDependencies();

}

// Initialize Hive Service
_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

// Initialize API Service
_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio(), getIt<TokenSharedPrefs>()).dio,
  );
}

// Initialize SharedPreferences
_initSharedPrefs() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
}

// Initialize Game Dependencies
_initGameDependencies() {
  getIt.registerLazySingleton<GameLocalDataSource>(
    () => GameLocalDataSource(hiveService: getIt<HiveService>()),
  );
  getIt.registerLazySingleton<GameRemoteDataSource>(
      () => GameRemoteDataSource(getIt<Dio>()));

  getIt.registerLazySingleton<GameLocalRepository>(
      () => GameLocalRepository(gameLocalDataSource: getIt()));

  getIt.registerLazySingleton<GameRemoteRepository>(() => GameRemoteRepository(
      gameRemoteDataSource: getIt<GameRemoteDataSource>()));

  // Conditionally provide the repository based on network connection
  getIt.registerLazySingleton<IGameRepository>(() {
    return GameRepositoryProxy(
      connectivityListener: getIt<ConnectivityListener>(),
      remoteRepository: getIt<GameRemoteRepository>(),
      localRepository: getIt<GameLocalRepository>(),
    );
  });

  // Register UseCases
  getIt.registerLazySingleton<CreateGameUsecase>(
    () => CreateGameUsecase(gameRepository: getIt<IGameRepository>()),
  );

  getIt.registerLazySingleton<GetallGamePlatformUsecase>(() =>
      GetallGamePlatformUsecase(
          gameRepository: getIt<IGameRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));

  getIt.registerLazySingleton<UploadGameImageUsecase>(
      () => UploadGameImageUsecase(repository: getIt<IGameRepository>()));

  getIt.registerLazySingleton<GetallgamesUsecase>(() => GetallgamesUsecase(
      gameRepository: getIt<IGameRepository>(), tokenSharedPrefs: getIt()));

  getIt.registerLazySingleton<GetallCategoriesUsecase>(() =>
      GetallCategoriesUsecase(
          gameRepository: getIt<IGameRepository>(), tokenSharedPrefs: getIt()));

  // Register GameBloc
  getIt.registerFactory<GameBloc>(
    () => GameBloc(
      getallPlatformUseCase: getIt(),
      getallCategoriesUsecase: getIt(),
      createGameUseCase: getIt(),
      getAllGamesUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

// Initialize other dependencies (unchanged)
_initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      getIt<AuthRemoteRepository>(),
      getIt(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      tokenSharedPrefs: getIt(),
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUsecase>(),
    ),
  );
}

// Other dependency initializations (unchanged)
_initOnboardingDependency() async {
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}

__initRegisterDependencies() {
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(hiveService: getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));

  getIt.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepository(authLocalDataSource: getIt()));

  getIt.registerLazySingleton<AuthRemoteRepository>(() => AuthRemoteRepository(
      authRemoteDataSource: getIt<AuthRemoteDataSource>()));

  getIt.registerLazySingleton<IAuthRepository>(
    () =>
        AuthLocalRepository(authLocalDataSource: getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<UpdateUserUsecase>(
    () => UpdateUserUsecase(authRepository: getIt<AuthRemoteRepository>()),
  );
  getIt.registerLazySingleton<RegisterUserUsecase>(
    () => RegisterUserUsecase(authRepository: getIt<AuthRemoteRepository>()),
  );
  getIt.registerLazySingleton<GetUserDataUsecase>(
      () => GetUserDataUsecase(authRepository: getIt<AuthRemoteRepository>()));

  getIt.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(repository: getIt<AuthRemoteRepository>()));

  getIt.registerLazySingleton<UserBloc>(
      () => UserBloc(updateUserUsecase: getIt(), uploadImageUsecase: getIt(),getUserDataUsecase: getIt()));
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      uploadImageUsecase: getIt<UploadImageUsecase>(),
      registerUserUsecase: getIt<RegisterUserUsecase>(),
    ),
  );
}

// Other feature dependencies (unchanged)
_initSkinsDependencies() async {
  getIt.registerLazySingleton<SkinLocalDataSource>(
    () => SkinLocalDataSource(hiveService: getIt<HiveService>()),
  );
  getIt.registerLazySingleton<SkinRemoteDataSource>(
      () => SkinRemoteDataSource(getIt<Dio>()));

  getIt.registerLazySingleton<SkinLocalRepository>(
      () => SkinLocalRepository(gameLocalDataSource: getIt()));

  getIt.registerLazySingleton<SkinRemoteRepository>(() => SkinRemoteRepository(
      skinRemoteDataSource: getIt<SkinRemoteDataSource>()));

  getIt.registerLazySingleton<ISkinRepository>(
    () =>
        SkinLocalRepository(gameLocalDataSource: getIt<SkinLocalDataSource>()),
  );

  getIt.registerLazySingleton<CreateskinUsecase>(
    () => CreateskinUsecase(skinRepository: getIt<SkinRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadskinImageUsecase>(
      () => UploadskinImageUsecase(repository: getIt<SkinRemoteRepository>()));

  getIt.registerLazySingleton<GetallskinsUsecase>(() => GetallskinsUsecase(
      skinRepository: getIt<SkinRemoteRepository>(),
      tokenSharedPrefs: getIt()));

  getIt.registerLazySingleton<GetallCategoriesUsecaseSkins>(() =>
      GetallCategoriesUsecaseSkins(
          gameRepository: getIt(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));

  getIt.registerLazySingleton<GetallPlatformUsecase>(() =>
      GetallPlatformUsecase(
          gameRepository: getIt<SkinRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
  getIt.registerFactory<SkinBloc>(() => SkinBloc(
        getallCategoriesUsecase: getIt<GetallCategoriesUsecaseSkins>(),
        createskinUseCase: getIt<CreateskinUsecase>(),
        getAllskinsUseCase: getIt<GetallskinsUsecase>(),
        uploadImageUsecase: getIt<UploadskinImageUsecase>(),
        getallPlatformUsecase: getIt<GetallPlatformUsecase>(),
      ));
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initForumDependencies() async {
  getIt.registerLazySingleton<ForumRemoteDataSource>(
      () => ForumRemoteDataSource(getIt<Dio>()));
  getIt.registerLazySingleton<ForumLocalDataSource>(
      () => ForumLocalDataSource(hiveService: getIt()));

  getIt.registerLazySingleton<ForumRemoteRepository>(
      () => ForumRemoteRepository(remoteDataSource: getIt()));

  getIt.registerLazySingleton<ForumLocalRepository>(
      () => ForumLocalRepository(localDataSource: getIt()));

  getIt.registerLazySingleton<IForumRepository>(() {
    return ForumRepositoryProxy(
      connectivityListener: getIt<ConnectivityListener>(),
      remoteRepository: getIt<ForumRemoteRepository>(),
      localRepository: getIt<ForumLocalRepository>(),
    );
  });
  getIt.registerLazySingleton<CreatePostUsecase>(
    () => CreatePostUsecase(repositoy: getIt<IForumRepository>()),
  );

  // Register UseCases
  getIt.registerLazySingleton<GetAllPostUsecase>(
      () => GetAllPostUsecase(repository: getIt<IForumRepository>()));

  getIt.registerLazySingleton<LikePostUsecase>(
    () => LikePostUsecase(repository: getIt<ForumRemoteRepository>()),
  );
  getIt.registerLazySingleton<DislikePostUsecase>(
    () => DislikePostUsecase(repository: getIt<ForumRemoteRepository>()),
  );
  getIt.registerLazySingleton<CreateCommentUsecase>(
    () => CreateCommentUsecase(repository: getIt<IForumRepository>()),
  );
  getIt.registerLazySingleton<ReplyCommentUsecase>(
      () => ReplyCommentUsecase(repository: getIt<ForumRemoteRepository>()));
  getIt.registerLazySingleton<GetCommentsUseCase>(
      () => GetCommentsUseCase(repositoy: getIt<ForumRemoteRepository>()));
      getIt.registerLazySingleton<DeletePostUsecase>(
      () => DeletePostUsecase(repository: getIt<ForumRemoteRepository>()));
      getIt.registerLazySingleton<EditPostUsecase>(
      () => EditPostUsecase(repository: getIt<ForumRemoteRepository>()));
        getIt.registerLazySingleton<GetPostUsecase>(
      () => GetPostUsecase(repository: getIt<ForumRemoteRepository>()));

  getIt.registerFactory<ForumBloc>(() => ForumBloc(
      createCommentUsecase: getIt(),
      deletePostUsecase: getIt(),
      getPostUsecase: getIt(),
      editPostUsecase: getIt(),
      createPostUseCase: getIt(),
      dislikePostUseCse: getIt(),
      likePostUseCase: getIt(),
      getallPostUseCase: getIt(),
      replyCommentUsecase: getIt(),
      getCommentsUseCase: getIt()));
}

_initCartDependency() async {
   getIt.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSource(dio: getIt<Dio>()));


  getIt.registerLazySingleton<CartRemoteRepo>(
      () => CartRemoteRepo(cartRemoteDataSource: getIt()));


  // getIt.registerLazySingleton<ICartRepository>(() {
  //   return ForumRepositoryProxy(
  //     connectivityListener: getIt<ConnectivityListener>(),
  //     remoteRepository: getIt<ForumRemoteRepository>(),
  //     localRepository: getIt<ForumLocalRepository>(),
  //   );
  // });
  getIt.registerLazySingleton<AddToCartUsecase>(
    () => AddToCartUsecase(cartRepository: getIt<CartRemoteRepo>()),
  );
    getIt.registerLazySingleton<GetCartItemsUsecase>(
    () => GetCartItemsUsecase(cartRepository: getIt<CartRemoteRepo>()),
  );
     getIt.registerLazySingleton<ClearCartUsecase>(
    () => ClearCartUsecase(cartRepository: getIt<CartRemoteRepo>()),
  );
  getIt.registerFactory<CartBloc>(() => CartBloc(
    addToCartUsecase: getIt(),
    getCartItemsUseCase: getIt(),
    clearCartUsecase: getIt()
  ));
}

_initSellerDependencies() {
  getIt.registerLazySingleton<SellerCubit>(() => SellerCubit());
}

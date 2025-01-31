import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/network/api_service.dart';
import 'package:loot_vault/core/network/hive_service.dart';
import 'package:loot_vault/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:loot_vault/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:loot_vault/features/auth/data/repository/auth_local_repository.dart';
import 'package:loot_vault/features/auth/data/repository/auth_remote_repository.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';
import 'package:loot_vault/features/auth/domain/use_case/login_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';
import 'package:loot_vault/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';


final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPrefs();

  await _initHomeDependencies();
  await __initRegisterDependencies();
  await _initLoginDependencies();
  await _initOnboardingDependency();

}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService(){
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );

}

_initSharedPrefs() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
}


_initLoginDependencies() async {
     getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      getIt<AuthRemoteRepository>(),
      getIt(),
    ),
  );

    // Register LoginBloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUsecase>(),
    ),
  );


}

_initOnboardingDependency()async{
    getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());

}


__initRegisterDependencies() {

  // Register AuthLocalDataSource
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(hiveService: getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSource(getIt<Dio>()));


  getIt. registerLazySingleton<AuthLocalRepository>(()=>AuthLocalRepository( authLocalDataSource: getIt()));

  getIt.registerLazySingleton<AuthRemoteRepository>(()=>
  AuthRemoteRepository(authRemoteDataSource:getIt<AuthRemoteDataSource>()));

  // Register IAuthRepository
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthLocalRepository(authLocalDataSource: getIt<AuthLocalDataSource>()),
  );

  // Register RegisterUserUsecase
  getIt.registerLazySingleton<RegisterUserUsecase>(
    () => RegisterUserUsecase(authRepository: getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    ()=>UploadImageUsecase(repository: getIt<AuthRemoteRepository>()));

  // Register RegisterBloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      uploadImageUsecase: getIt<UploadImageUsecase>(),
      registerUserUsecase: getIt<RegisterUserUsecase>(),
    ),
  );

 
}





_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}



// _initSplashScreenDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<LoginBloc>()),
//   );
// }

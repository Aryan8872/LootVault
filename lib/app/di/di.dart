import 'package:get_it/get_it.dart';
import 'package:loot_vault/core/network/hive_service.dart';
import 'package:loot_vault/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:loot_vault/features/auth/data/repository/auth_local_repository.dart';
import 'package:loot_vault/features/auth/domain/repository/auth_repository.dart';
import 'package:loot_vault/features/auth/domain/use_case/login_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';
import 'package:loot_vault/features/onboarding/presentation/view_model/onboarding_cubit.dart';


final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();


  await _initHomeDependencies();
  await __initRegisterDependencies();
  await _initLoginDependencies();
  await _initOnboardingDependency();

}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}


_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      getIt<AuthLocalRepository>(),
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


    getIt. registerLazySingleton<AuthLocalRepository>(()=>AuthLocalRepository( authLocalDataSource: getIt()));


  // Register IAuthRepository
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthLocalRepository(authLocalDataSource: getIt<AuthLocalDataSource>()),
  );

  // Register RegisterUserUsecase
  getIt.registerLazySingleton<RegisterUserUsecase>(
    () => RegisterUserUsecase(authRepository: getIt<IAuthRepository>()),
  );

  // Register RegisterBloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUserUsecase: getIt<RegisterUserUsecase>(),
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

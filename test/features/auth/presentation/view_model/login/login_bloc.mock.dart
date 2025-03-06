import 'package:flutter/material.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/features/auth/domain/use_case/login_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockBuildContext extends Mock implements BuildContext {}
class MockRegisterBloc extends Mock implements RegisterBloc {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

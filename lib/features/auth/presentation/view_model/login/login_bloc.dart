import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/auth/domain/use_case/login_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:loot_vault/features/home/presentation/view/homepage_view.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUsecase _loginUseCase;
  final TokenSharedPrefs _tokenSharedPrefs;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUsecase loginUseCase,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _registerBloc = registerBloc,
        _loginUseCase = loginUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        _homeCubit = homeCubit,
        super(LoginState.initial()) {
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      print(event.email);
      print(event.password);

      final result = await _loginUseCase(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      await result.fold(
        (failure) async {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: failure.message ?? "Login failed",
            color: Colors.red,
          );
        },
        (loginResponse) async {
          // Store data using TokenSharedPrefs
          await _tokenSharedPrefs.saveToken(loginResponse.accessToken);
          await _tokenSharedPrefs.saveUserData({
            'user': {
              'id': loginResponse.user.id,
              'email': loginResponse.user.email,
              'role': loginResponse.user.role,
            },
            'refreshToken': loginResponse.refreshToken,
          });

          emit(state.copyWith(isLoading: false, isSuccess: true));
          add(
            NavigateHomeScreenEvent(
              context: event.context,
              destination: const HomePageView(),
            ),
          );
        },
      );
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: event.destination,
          ),
        ),
      );
    });

    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _registerBloc,
            child: event.destination,
          ),
        ),
      );
    });
  }
}
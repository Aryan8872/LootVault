import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // final LoginBloc _loginBloc;
  final RegisterUserUsecase _registerUserUsecase;
  RegisterBloc({
    // required LoginBloc loginBloc,
    required RegisterUserUsecase registerUserUsecase,
    })
      : 
      _registerUserUsecase= registerUserUsecase,
        super(RegisterState.initial()) {
    // on<NavigateLoginScreen>((event, emit) => Navigator.push(
    //     event.context,
    //     MaterialPageRoute(
    //       builder: (context) => BlocProvider.value(value: _loginBloc),
    //     )));


    on<RegisterUser>(_onRegisterEvent);
  }
  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState>emit,
  )async{
    emit(state.copyWith(isLoading: true));
    final result = await _registerUserUsecase.call(RegisterUserParams(
      fullName: event.fullName,
      email: event.email,
      username: event.userName,
      phoneNo: event.phoneNo,
      password: event.password
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }



}

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUsecase _registerUserUsecase;
  final UploadImageUsecase _uploadImageUsecase;


  RegisterBloc({
    required RegisterUserUsecase registerUserUsecase,
    required UploadImageUsecase uploadImageUsecase
    })
      : 
      _registerUserUsecase= registerUserUsecase,
      _uploadImageUsecase = uploadImageUsecase,
        super(RegisterState.initial()) {

    on<RegisterUser>(_onRegisterEvent);
    on<UploadImageEvent>(_onUploadImageEvent);
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
      image: event.image,
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

    void _onUploadImageEvent(UploadImageEvent event,Emitter<RegisterState> emit,)async{
    emit(state.copyWith(isLoading: true));

    final result = await _uploadImageUsecase.call(UploadImageParams(
      image: event.img
    ));    

      result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "image upload Successful");
      },
    );

  }



}

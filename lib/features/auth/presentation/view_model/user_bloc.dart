import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_event.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UpdateUserUsecase _updateUserUsecase;
  final UploadImageUsecase _uploadImageUsecase;

  UserBloc({
    required UpdateUserUsecase updateUserUsecase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _updateUserUsecase = updateUserUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const UserState.initial()) {
    on<UpdateUser>(_onUpdateUserEvent);
    on<UploadImageEvent>(_onUploadImageEvent);
  }

  void _onUpdateUserEvent(
    UpdateUser event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _updateUserUsecase.call(UpdateUserParams(
      userId: event.userId, // Pass userId
      fullName: event.fullName,
      email: event.email,
      username: event.userName,
      phoneNo: event.phoneNo,
      password: event.password,
      image: event.image,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: "Failed to update profile: ${failure.message}",
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Profile updated successfully",
        );
      },
    );
  }

  void _onUploadImageEvent(
    UploadImageEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _uploadImageUsecase.call(UploadImageParams(image: event.img));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: "Failed to upload image: ${failure.message}",
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Image uploaded successfully",
        );
      },
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/auth/domain/use_case/get_user_data_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:loot_vault/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_event.dart';
import 'package:loot_vault/features/auth/presentation/view_model/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UpdateUserUsecase _updateUserUsecase;
  final UploadImageUsecase _uploadImageUsecase;
  final GetUserDataUsecase _getUserDataUsecase;

  UserBloc({
    required UpdateUserUsecase updateUserUsecase,
    required GetUserDataUsecase getUserDataUsecase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _updateUserUsecase = updateUserUsecase,
        _getUserDataUsecase = getUserDataUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const UserState.initial()) {
    on<UpdateUser>(_onUpdateUserEvent);
    on<UploadImageEvent>(_onUploadImageEvent);
    on<GetUserData>(_onGetData);
  }

  void _onUpdateUserEvent(
    UpdateUser event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _updateUserUsecase.call(UpdateUserParams(
      userId: event.userId,
      fullName: event.fullName,
      email: event.email,
      username: event.userName,
      phoneNo: event.phoneNo,
      password: event.password,
      image: event.image,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false, profileUpdated: false));
        showMySnackBar(
          context: event.context,
          message: "Failed to update profile: ${failure.message}",
        );
      },
      (success) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          profileUpdated: true, // Trigger UI update
        ));
        showMySnackBar(
          context: event.context,
          message: "Profile updated successfully",
        );

        // Reset profileUpdated after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          emit(state.copyWith(profileUpdated: false));
        });
      },
    );
  }

  void _onGetData(GetUserData event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getUserDataUsecase.call(GetUserParams(userId: event.userId));
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (userData) => emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        userId: userData.userId,
        username: userData.username,
        fullName: userData.fullName,
        email: userData.email,
        phoneNo: userData.phoneNo,
        password: userData.password,
        image: userData.image, // Ensure image is emitted
      )),
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
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true, // Update image in state
        ));
        showMySnackBar(
          context: event.context,
          message: "Image uploaded successfully",
        );
      },
    );
  }
}
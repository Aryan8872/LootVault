import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final String userId;
  final String username;
  final String phoneNo;
  final String fullName;
  final String password;
  final String email;
  final String? image;
  final bool isLoading;
  final bool isSuccess;

  const UserState.initial()
      : isLoading = false,
        isSuccess = false,
        email = "",
        fullName = "",
        password = "",
        image = "",
        phoneNo = "",
        username = "",
        userId = "";

  const UserState(
      {required this.userId,
      required this.username,
      this.image,
      required this.email,
      required this.phoneNo,
      required this.isLoading,
      required this.isSuccess,
      required this.fullName,
      required this.password});

  UserState copyWith({
    String? userId,
    String? username,
    String? phoneNo,
    String? fullName,
    String? image,
    String? password,
    String? email,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return UserState(
        username: username ?? this.username,
        phoneNo: phoneNo ?? this.phoneNo,
        fullName: fullName ?? this.fullName,
        image: image ?? this.image,
        password: password ?? this.password,
        email: email ?? this.email,
        userId: userId ?? this.userId,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userId, username, phoneNo, fullName, password];
}

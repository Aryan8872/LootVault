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
  final bool? profileUpdated;

  const UserState({
    required this.userId,
    required this.username,
    required this.phoneNo,
    required this.fullName,
    required this.password,
    required this.email,
    this.image,
    this.isLoading = false,
    this.isSuccess = false,
    this.profileUpdated = false,
  });

  const UserState.initial()
      : isLoading = false,
        isSuccess = false,
        profileUpdated = false,
        email = "",
        fullName = "",
        password = "",
        image = "",
        phoneNo = "",
        username = "",
        userId = "";

  UserState copyWith({
    String? userId,
    String? username,
    String? phoneNo,
    String? fullName,
    String? image, // Nullable image
    String? password,
    String? email,
    bool? isLoading,
    bool? profileUpdated,
    bool? isSuccess,
  }) {
    return UserState(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      phoneNo: phoneNo ?? this.phoneNo,
      fullName: fullName ?? this.fullName,
      image: image ?? this.image, // Allow explicit `null`
      password: password ?? this.password,
      email: email ?? this.email,
      profileUpdated: profileUpdated ?? this.profileUpdated,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        userId,
        username,
        phoneNo,
        fullName,
        password,
        email,
        image,
        isLoading,
        isSuccess,
        profileUpdated
      ];
}

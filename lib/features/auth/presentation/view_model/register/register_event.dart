part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class NavigateLoginScreen extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreen({required this.context, 
  required this.destination});
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String userName;
  final String email;
  final String phoneNo;
  final String? image;
  final String password;

  const RegisterUser({
    required this.context, 
    required this.fullName, 
    required this.userName, 
    required this.email, 
    this.image,
    required this.phoneNo, 
    required this.password});
}

class UploadImageEvent extends RegisterEvent{
  final BuildContext context;
  final File img;

  const UploadImageEvent({
    required this.context,
    required this.img
  });

}

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
  final String password;

  const RegisterUser({
    required this.context, 
    required this.fullName, 
    required this.userName, 
    required this.email, 
    required this.phoneNo, 
    required this.password});
}

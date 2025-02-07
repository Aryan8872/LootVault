import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String username;
  final String fullName;
  final String email;
  final String password;
  final String phoneNo;
  final String? image;

  const AuthEntity(
      {this.userId,
      required this.username,
      required this.phoneNo,
      required this.fullName,
      required this.email,
      required this.password,
      this.image});

  const AuthEntity.initial(
      {this.userId = '',
      this.username = '',
      this.fullName = '',
      this.email = '',
      this.password = '',
      this.phoneNo = '',
      this.image = ''});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [userId, username, fullName, email, password, phoneNo, image];
}

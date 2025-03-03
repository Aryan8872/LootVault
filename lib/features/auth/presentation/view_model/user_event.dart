
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


class UpdateUser extends UserEvent {
  final BuildContext context;
  final String fullName;
  final String userName;
  final String userId;
  final String email;
  final String phoneNo;
  final String? image;
  final String password;

  const UpdateUser({
    required this.context, 
    required this.fullName, 
    required this.userId,
    required this.userName, 
    required this.email, 
    this.image,
    required this.phoneNo, 
    required this.password});
}

class UploadImageEvent extends UserEvent{
  final BuildContext context;
  final File img;

  const UploadImageEvent({
    required this.context,
    required this.img
  });

}

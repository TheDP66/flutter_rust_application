import 'package:InOut/core/params/user_params.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AccountScreenEvent {}

class LogoutUser extends AccountScreenEvent {
  LogoutUser();
}

class FetchMeUser extends AccountScreenEvent {
  FetchMeUser();
}

class UpdateUser extends AccountScreenEvent {
  final UpdatePhotoParams params;

  UpdateUser(this.params);
}

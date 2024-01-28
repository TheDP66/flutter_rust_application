import 'package:InOut/core/params/auth_params.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginScreenEvent {}

class FetchLoginUser extends LoginScreenEvent {
  final LoginUserParams params;

  FetchLoginUser(this.params);
}

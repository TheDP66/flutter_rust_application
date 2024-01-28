import 'package:InOut/core/params/auth_params.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterScreenEvent {}

class FetchRegisterUser extends RegisterScreenEvent {
  final RegisterUserParams params;

  FetchRegisterUser(this.params);
}

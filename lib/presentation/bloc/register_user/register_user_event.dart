import 'package:flutter_rust_application/core/params/auth_params.dart';

abstract class RegisterUserEvent {}

class FetchRegisterUser extends RegisterUserEvent {
  final RegisterUserParams params;

  FetchRegisterUser(this.params);
}

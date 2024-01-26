import 'package:flutter_rust_application/domain/entities/user_entity.dart';

abstract class RegisterUserState {}

class RegisterUserInintial extends RegisterUserState {}

class RegisterUserLoading extends RegisterUserState {}

class RegisterUserLoaded extends RegisterUserState {
  final UserEntity user;

  RegisterUserLoaded(this.user);
}

class RegisterUserError extends RegisterUserState {
  final String message;

  RegisterUserError(this.message);
}

import 'package:InOut/domain/entities/token_entity.dart';

class RegisterScreenState {}

class RegisterUserInintial extends RegisterScreenState {}

class RegisterUserLoading extends RegisterScreenState {}

class RegisterUserLoaded extends RegisterScreenState {
  final TokenEntity token;

  RegisterUserLoaded(this.token);
}

class RegisterUserError extends RegisterScreenState {
  final String message;

  RegisterUserError(this.message);
}

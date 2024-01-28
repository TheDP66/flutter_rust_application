import 'package:InOut/domain/entities/token_entity.dart';

class LoginScreenState {}

class LoginUserInitial extends LoginScreenState {}

class LoginUserLoading extends LoginScreenState {}

class LoginUserLoaded extends LoginScreenState {
  final TokenEntity token;

  LoginUserLoaded(this.token);
}

class LoginUserError extends LoginScreenState {
  final String message;

  LoginUserError(this.message);
}

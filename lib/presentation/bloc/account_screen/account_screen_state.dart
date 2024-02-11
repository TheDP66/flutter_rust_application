import 'package:InOut/domain/entities/user_entity.dart';

class AccountScreenState {}

class AccountInitial extends AccountScreenState {}

class AccountLoading extends AccountScreenState {}

class AccountLoaded extends AccountScreenState {
  final UserEntity user;

  AccountLoaded(this.user);
}

class AccountError extends AccountScreenState {
  final String message;

  AccountError(this.message);
}

class UpdateUserLoading extends AccountScreenState {}

class UpdateUserLoaded extends AccountScreenState {
  final String message;

  UpdateUserLoaded(this.message);
}

class UpdateUserError extends AccountScreenState {
  final String message;

  UpdateUserError(this.message);
}

class LogoutLoading extends AccountScreenState {}

class LogoutLoaded extends AccountScreenState {
  final String message;

  LogoutLoaded(this.message);
}

class LogoutError extends AccountScreenState {
  final String message;

  LogoutError(this.message);
}

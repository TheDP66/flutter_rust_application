import 'package:InOut/domain/entities/user_entity.dart';

class AccountScreenState {}

class AccountInitial extends AccountScreenState {}

class AccountLoading extends AccountScreenState {}

class LogoutLoading extends AccountScreenState {}

class AccountLoaded extends AccountScreenState {
  final UserEntity user;

  AccountLoaded(this.user);
}

class LogoutLoaded extends AccountScreenState {
  final String message;

  LogoutLoaded(this.message);
}

class AccountError extends AccountScreenState {
  final String message;

  AccountError(this.message);
}

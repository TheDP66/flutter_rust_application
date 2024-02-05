import 'package:flutter/material.dart';

@immutable
abstract class AccountScreenEvent {}

class LogoutUser extends AccountScreenEvent {
  LogoutUser();
}

class FetchMeUser extends AccountScreenEvent {
  FetchMeUser();
}

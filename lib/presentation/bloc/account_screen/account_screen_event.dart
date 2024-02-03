import 'package:flutter/material.dart';

@immutable
abstract class AccountScreenEvent {}

class LogoutUser extends AccountScreenEvent {
  LogoutUser();
}

class MeUser extends AccountScreenEvent {
  MeUser();
}

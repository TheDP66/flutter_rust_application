import 'package:InOut/domain/entities/user_entity.dart';

class ExploreScreenState {}

class ExploreInitial extends ExploreScreenState {}

class SyncLoading extends ExploreScreenState {}

class SyncLoaded extends ExploreScreenState {
  final String message;

  SyncLoaded(this.message);
}

class SyncError extends ExploreScreenState {
  final String message;

  SyncError(this.message);
}

class MeLoading extends ExploreScreenState {}

class MeLoaded extends ExploreScreenState {
  final UserEntity user;

  MeLoaded(this.user);
}

class MeError extends ExploreScreenState {
  final String message;

  MeError(this.message);
}

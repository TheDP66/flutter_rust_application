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

import 'package:InOut/domain/entities/barang_entity.dart';

class DashboardScreenState {}

class DashboardInitial extends DashboardScreenState {}

class DashboardLoading extends DashboardScreenState {}

class DashboardLoaded extends DashboardScreenState {
  final List<BarangEntity> barang;

  DashboardLoaded(this.barang);
}

class DashboardError extends DashboardScreenState {
  final String message;

  DashboardError(this.message);
}

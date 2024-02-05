import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/entities/user_entity.dart';

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

class ExportPackageLoading extends DashboardScreenState {}

class ExportPackageLoaded extends DashboardScreenState {
  final List<BarangEntity> barang;
  final UserEntity user;

  ExportPackageLoaded(this.barang, this.user);
}

class ExportPackageError extends DashboardScreenState {
  final String message;

  ExportPackageError(this.message);
}

import 'package:InOut/domain/entities/barang_entity.dart';

class PackageScreenState {}

class PackageInitial extends PackageScreenState {}

class PackageLoading extends PackageScreenState {}

class PackageLoaded extends PackageScreenState {
  final BarangEntity barang;

  PackageLoaded(this.barang);
}

class PackageError extends PackageScreenState {
  final String message;

  PackageError(this.message);
}

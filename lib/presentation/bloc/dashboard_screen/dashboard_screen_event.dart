import 'package:InOut/core/params/barang_params.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DashboardScreenEvent {}

class FetchBarang extends DashboardScreenEvent {
  final GetBarangParams params;

  FetchBarang(this.params);
}

class PrepExportPackage extends DashboardScreenEvent {
  final GetBarangParams params;

  PrepExportPackage(this.params);
}

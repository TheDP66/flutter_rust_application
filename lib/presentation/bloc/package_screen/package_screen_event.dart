import 'package:InOut/core/params/barang_params.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PackageScreenEvent {}

class InsertBarang extends PackageScreenEvent {
  final InsertBarangParams params;

  InsertBarang(this.params);
}

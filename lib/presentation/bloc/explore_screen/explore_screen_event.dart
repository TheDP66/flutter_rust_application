import 'package:InOut/core/params/barang_params.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ExploreScreenEvent {}

class SyncBarang extends ExploreScreenEvent {
  final SyncBarangParams params;

  SyncBarang(this.params);
}

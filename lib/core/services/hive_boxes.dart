import 'package:InOut/core/hive/barang.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static Box<BarangHive> getBarangs() => Hive.box<BarangHive>('barangs');
}

import 'package:hive/hive.dart';

part 'barang.g.dart';

class Barangs {
  late String name;
  late int price;
  late int stock;
  late String? expired_at;
}

@HiveType(typeId: 0)
class BarangHive extends HiveObject implements Barangs {
  @HiveField(0)
  @override
  String name;

  @HiveField(1)
  @override
  int price;

  @HiveField(2)
  @override
  int stock;

  @HiveField(3)
  @override
  String? expired_at;

  BarangHive({
    required this.name,
    required this.price,
    required this.stock,
    this.expired_at,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'expired_at': expired_at == "" ? null : expired_at,
    };
  }

  static List<Map<String, dynamic>> jsonFromList(List<BarangHive> barangs) {
    List<Map<String, dynamic>> barangList = [];
    for (var barang in barangs) {
      barangList.add(barang.toJson());
    }
    return barangList;
  }
}

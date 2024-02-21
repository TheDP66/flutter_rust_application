import 'package:hive/hive.dart';

part 'barang.g.dart';

class Barangs {
  late String name;
  late int price;
  late int stock;
  late String? expiredAt;
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
  String? expiredAt;

  BarangHive({
    required this.name,
    required this.price,
    required this.stock,
    this.expiredAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'expiredAt': expiredAt,
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

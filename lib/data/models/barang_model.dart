import 'package:InOut/domain/entities/barang_entity.dart';

class BarangModel extends BarangEntity {
  BarangModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
          price: json['price'],
          stock: json['stock'],
          expired_at: json['expired_at'],
          created_at: json['created_at'],
          updated_at: json['updated_at'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['stock'] = stock;
    data['expired_at'] = expired_at;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }

  static List<BarangEntity> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => BarangModel.fromJson(json).toEntity())
        .toList();
  }

  BarangEntity toEntity() {
    return BarangEntity(
      id: id,
      name: name,
      price: price,
      stock: stock,
      expired_at: expired_at,
      created_at: created_at,
      updated_at: updated_at,
    );
  }
}

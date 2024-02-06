import 'package:InOut/domain/entities/barang_entity.dart';

class BarangModel extends BarangEntity {
  BarangModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
          price: json['price'],
          stock: json['stock'],
          expiredAt: json['expiredAt'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['stock'] = stock;
    data['expiredAt'] = expiredAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
      expiredAt: expiredAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

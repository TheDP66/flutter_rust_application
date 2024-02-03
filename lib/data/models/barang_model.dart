import 'package:InOut/domain/entities/barang_entity.dart';

class BarangModel extends BarangEntity {
  BarangModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
          price: json['price'],
          stock: json['stock'],
          expiredAt: json['expiredAt'] ?? null,
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['expiredAt'] = this.expiredAt ?? null;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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

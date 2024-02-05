import 'package:equatable/equatable.dart';

class BarangEntity extends Equatable {
  String? id;
  String? name;
  int? price;
  int? stock;
  String? expiredAt;
  String? createdAt;
  String? updatedAt;

  BarangEntity({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        stock,
        expiredAt,
        createdAt,
        updatedAt,
      ];
}

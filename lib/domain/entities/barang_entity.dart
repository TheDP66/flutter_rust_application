import 'package:equatable/equatable.dart';

class BarangEntity extends Equatable {
  String? id;
  String? name;
  int? price;
  int? stock;
  String? expired_at;
  String? created_at;
  String? updated_at;

  BarangEntity({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.expired_at,
    this.created_at,
    this.updated_at,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        stock,
        expired_at,
        created_at,
        updated_at,
      ];
}

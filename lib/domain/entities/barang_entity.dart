import 'package:equatable/equatable.dart';

class BarangEntity extends Equatable {
  String id;
  String name;
  int price;
  int stock;
  String? expiredAt;
  String createdAt;
  String updatedAt;

  BarangEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
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

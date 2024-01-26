import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String? createdAt;
  String? email;
  String? id;
  String? name;
  String? photo;
  String? role;
  String? updatedAt;
  bool? verified;

  UserEntity({
    this.createdAt,
    this.email,
    this.id,
    this.name,
    this.photo,
    this.role,
    this.updatedAt,
    this.verified,
  });

  @override
  List<Object?> get props => [
        createdAt,
        email,
        id,
        name,
        photo,
        role,
        updatedAt,
        verified,
      ];
}

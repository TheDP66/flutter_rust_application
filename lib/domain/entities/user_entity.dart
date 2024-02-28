import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String? created_at;
  String? email;
  String? id;
  String? name;
  String? photo;
  String? role;
  String? updated_at;
  bool? verified;

  UserEntity({
    this.created_at,
    this.email,
    this.id,
    this.name,
    this.photo,
    this.role,
    this.updated_at,
    this.verified,
  });

  @override
  List<Object?> get props => [
        created_at,
        email,
        id,
        name,
        photo,
        role,
        updated_at,
        verified,
      ];
}

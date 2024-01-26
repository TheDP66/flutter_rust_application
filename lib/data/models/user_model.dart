import 'package:flutter_rust_application/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    role = json['role'];
    updatedAt = json['updatedAt'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['role'] = this.role;
    data['updatedAt'] = this.updatedAt;
    data['verified'] = this.verified;
    return data;
  }

  UserEntity toEntity() {
    return UserEntity(
      createdAt: createdAt,
      email: email,
      id: id,
      name: name,
      photo: photo,
      role: role,
      updatedAt: updatedAt,
      verified: verified,
    );
  }
}

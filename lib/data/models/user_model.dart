import 'package:InOut/domain/entities/user_entity.dart';

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['role'] = role;
    data['updatedAt'] = updatedAt;
    data['verified'] = verified;
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

import 'package:InOut/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel.fromJson(Map<String, dynamic> json) {
    created_at = json['created_at'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    role = json['role'];
    updated_at = json['updated_at'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = created_at;
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['role'] = role;
    data['updated_at'] = updated_at;
    data['verified'] = verified;
    return data;
  }

  UserEntity toEntity() {
    return UserEntity(
      created_at: created_at,
      email: email,
      id: id,
      name: name,
      photo: photo,
      role: role,
      updated_at: updated_at,
      verified: verified,
    );
  }
}

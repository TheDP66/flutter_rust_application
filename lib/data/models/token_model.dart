import 'package:InOut/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    return data;
  }

  TokenEntity toEntity() {
    return TokenEntity(
      token: token,
    );
  }
}

import 'package:InOut/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel.fromJson(dynamic json) {
    token = json['token'];
  }

  dynamic toJSON() {
    const dynamic data = dynamic;

    data['token'] = token;

    return data;
  }

  TokenEntity toEntity() {
    return TokenEntity(
      token: token,
    );
  }
}

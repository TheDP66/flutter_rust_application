import 'package:InOut/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    refresh_token = json['refresh_token'];
    refresh_token_expired = json['refresh_token_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = access_token;
    data['refresh_token'] = refresh_token;
    data['refresh_token_expired'] = refresh_token_expired;
    return data;
  }

  TokenEntity toEntity() {
    return TokenEntity(
      access_token: access_token,
      refresh_token: refresh_token,
      refresh_token_expired: refresh_token_expired,
    );
  }
}

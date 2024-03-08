import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  String? access_token;
  String? refresh_token;
  int? refresh_token_expired;

  TokenEntity({
    this.access_token,
    this.refresh_token,
    this.refresh_token_expired,
  });

  @override
  List<Object?> get props => [
        access_token,
        refresh_token,
        refresh_token_expired,
      ];
}

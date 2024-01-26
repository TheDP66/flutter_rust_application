import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  String? token;

  TokenEntity({
    this.token,
  });

  @override
  List<Object?> get props => [
        token,
      ];
}

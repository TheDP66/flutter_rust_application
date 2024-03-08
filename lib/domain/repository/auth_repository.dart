import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/entities/token_entity.dart';

abstract class AuthRepository {
  Future<DataState<TokenEntity>> registerUserRepository(
    RegisterUserParams params,
  );

  Future<DataState<TokenEntity>> loginUserRepository(
    LoginUserParams params,
  );

  Future<DataState<String>> logoutUserRepository();

  Future<DataState<TokenEntity>> refreshTokenRepository(
    RefreshTokenParams params,
  );
}

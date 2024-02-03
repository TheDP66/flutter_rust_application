import 'package:InOut/core/params/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> registerUserRemote(
    RegisterUserParams params,
  );

  Future<Map<String, dynamic>> loginUserRemote(
    LoginUserParams params,
  );

  Future<Map<String, dynamic>> logoutUserRemote();
}

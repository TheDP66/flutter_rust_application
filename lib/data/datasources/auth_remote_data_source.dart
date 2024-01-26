import 'package:flutter_rust_application/core/params/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<dynamic> registerUserRemote(
    RegisterUserParams params,
  );

  // Future<List<>> loginUser();

  // Future<List<>> logoutUser();
}

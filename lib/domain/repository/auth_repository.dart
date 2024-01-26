import 'package:flutter_rust_application/core/params/auth_params.dart';
import 'package:flutter_rust_application/core/resources/data_state.dart';
import 'package:flutter_rust_application/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> registerUserRepository(
    RegisterUserParams params,
  );
}

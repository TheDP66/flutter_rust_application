import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> registerUserRepository(
    RegisterUserParams params,
  );
}

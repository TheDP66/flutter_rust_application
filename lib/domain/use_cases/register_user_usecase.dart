import 'package:flutter_rust_application/core/params/auth_params.dart';
import 'package:flutter_rust_application/core/resources/data_state.dart';
import 'package:flutter_rust_application/core/usecase/use_case.dart';
import 'package:flutter_rust_application/domain/entities/user_entity.dart';
import 'package:flutter_rust_application/domain/repository/auth_repository.dart';

class RegisterUserUseCase
    extends UseCase<DataState<UserEntity>, RegisterUserParams> {
  final AuthRepository authRepository;

  RegisterUserUseCase(this.authRepository);

  @override
  Future<DataState<UserEntity>> call(RegisterUserParams param) {
    return authRepository.registerUserRepository(param);
  }
}

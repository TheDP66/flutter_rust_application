import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/resources/use_case.dart';
import 'package:InOut/domain/entities/token_entity.dart';
import 'package:InOut/domain/repository/auth_repository.dart';

class LoginUserUseCase
    extends UseCase<DataState<TokenEntity>, LoginUserParams> {
  final AuthRepository authRepository;

  LoginUserUseCase(this.authRepository);

  @override
  Future<DataState<TokenEntity>> call(LoginUserParams param) {
    return authRepository.loginUserRepository(param);
  }
}

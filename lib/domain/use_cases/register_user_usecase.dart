import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/usecase/use_case.dart';
import 'package:InOut/domain/entities/token_entity.dart';
import 'package:InOut/domain/repository/auth_repository.dart';

class RegisterUserUseCase
    extends UseCase<DataState<TokenEntity>, RegisterUserParams> {
  final AuthRepository authRepository;

  RegisterUserUseCase(this.authRepository);

  @override
  Future<DataState<TokenEntity>> call(RegisterUserParams param) {
    return authRepository.registerUserRepository(param);
  }
}

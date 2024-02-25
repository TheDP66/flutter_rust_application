import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/resources/use_case.dart';
import 'package:InOut/domain/repository/auth_repository.dart';

class LogoutUserUseCase extends UseCase<DataState<String>, void> {
  final AuthRepository authRepository;

  LogoutUserUseCase(this.authRepository);

  @override
  Future<DataState<String>> call(void param) {
    return authRepository.logoutUserRepository();
  }
}

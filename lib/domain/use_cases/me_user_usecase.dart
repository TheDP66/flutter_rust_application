import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/usecase/use_case.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:InOut/domain/repository/user_repository.dart';

class MeUserUseCase extends UseCase<DataState<UserEntity>, void> {
  final UserRepository userRepository;

  MeUserUseCase(this.userRepository);

  @override
  Future<DataState<UserEntity>> call(void param) {
    return userRepository.meUserRepository();
  }
}

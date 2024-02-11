import 'package:InOut/core/params/user_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/usecase/use_case.dart';
import 'package:InOut/domain/repository/user_repository.dart';

class UpdateUserUseCase extends UseCase<DataState<String>, UpdatePhotoParams> {
  final UserRepository userRepository;

  UpdateUserUseCase(this.userRepository);

  @override
  Future<DataState<String>> call(UpdatePhotoParams param) {
    return userRepository.updateUserRepository(param);
  }
}

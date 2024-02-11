import 'package:InOut/core/params/user_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> meUserRepository();

  Future<DataState<String>> updateUserRepository(
    UpdatePhotoParams params,
  );
}

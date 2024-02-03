import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> meUserRepository();
}

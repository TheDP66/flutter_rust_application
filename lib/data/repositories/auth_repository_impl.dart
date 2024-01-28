import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/data/datasources/auth_remote_data_source.dart';
import 'package:InOut/data/models/user_model.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:InOut/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<DataState<UserEntity>> registerUserRepository(
      RegisterUserParams params) async {
    try {
      Map<String, dynamic> response = await remoteDataSource.registerUserRemote(
        params,
      );

      final user = response["data"]["user"];

      print("register repo user: ${user}");

      UserEntity userEntity = UserModel.fromJson(
        user,
      );

      return DataSuccess(userEntity);
    } catch (e) {
      print("repo register error: $e");

      return DataFailed(e.toString());
    }
  }
}

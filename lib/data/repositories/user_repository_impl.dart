import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/data/datasources/user_remote_data_source.dart';
import 'package:InOut/data/models/user_model.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:InOut/domain/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<DataState<UserEntity>> meUserRepository() async {
    try {
      Map<String, dynamic> response = await remoteDataSource.meUserRemote();

      UserEntity user = UserModel.fromJson(
        response["data"]["user"],
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user", user.toString());

      return DataSuccess(user);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> updateUserRepository(params) async {
    try {
      Map<String, dynamic> response =
          await remoteDataSource.updatePhotoRemote(params);

      String message = response["message"];

      return DataSuccess(message);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}

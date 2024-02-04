import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/data/datasources/auth_remote_data_source.dart';
import 'package:InOut/data/models/token_model.dart';
import 'package:InOut/domain/entities/token_entity.dart';
import 'package:InOut/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<DataState<TokenEntity>> registerUserRepository(
    RegisterUserParams params,
  ) async {
    try {
      Map<String, dynamic> response = await remoteDataSource.registerUserRemote(
        params,
      );

      TokenEntity tokenEntity = TokenModel.fromJson(
        response["data"],
      );

      return DataSuccess(tokenEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TokenEntity>> loginUserRepository(
    LoginUserParams params,
  ) async {
    try {
      Map<String, dynamic> response = await remoteDataSource.loginUserRemote(
        params,
      );

      TokenEntity tokenEntity = TokenModel.fromJson(
        response["data"],
      );

      return DataSuccess(tokenEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> logoutUserRepository() async {
    try {
      Map<String, dynamic> response = await remoteDataSource.logoutUserRemote();

      String message = response["message"];

      return DataSuccess(message);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}

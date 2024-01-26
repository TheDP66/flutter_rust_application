import 'package:dio/dio.dart';
import 'package:flutter_rust_application/core/params/auth_params.dart';
import 'package:flutter_rust_application/core/resources/data_state.dart';
import 'package:flutter_rust_application/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:flutter_rust_application/data/models/user_model.dart';
import 'package:flutter_rust_application/domain/entities/user_entity.dart';
import 'package:flutter_rust_application/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSourceImpl remoteDataSource;

  @override
  Future<DataState<UserEntity>> registerUserRepository(
      RegisterUserParams params) async {
    try {
      Response response = await remoteDataSource.registerUserRemote(params);

      print("registerUser: $response");

      UserEntity tokenEntity = UserModel.fromJson(response.data);

      return DataSuccess(tokenEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}

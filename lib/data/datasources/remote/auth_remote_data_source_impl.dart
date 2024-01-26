import 'package:dio/dio.dart';
import 'package:flutter_rust_application/core/utils/dio_provider.dart';
import 'package:flutter_rust_application/core/utils/error.dart';
import 'package:flutter_rust_application/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio = DioProvider().dio;

  @override
  Future<dynamic> registerUserRemote(params) async {
    try {
      Map<String, dynamic> request = {
        'email': params.email,
        'name': params.name,
        'password': params.password,
        'passwordConfirm': params.passwordConfirm,
      };

      var response = await _dio.post("/auth/register", data: request);

      print("registerUser: $response");

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }
}

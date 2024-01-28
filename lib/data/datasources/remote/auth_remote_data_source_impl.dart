import 'package:InOut/core/services/dio_provider.dart';
import 'package:InOut/core/utils/error.dart';
import 'package:InOut/data/datasources/auth_remote_data_source.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSourceImpl() : _dio = DioProvider().dio;

  @override
  Future<Map<String, dynamic>> registerUserRemote(params) async {
    try {
      Map<String, dynamic> request = {
        'email': params.email,
        'name': params.name,
        'password': params.password,
        'passwordConfirm': params.passwordConfirm,
      };

      final response = await _dio.post("/auth/register", data: request);

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }

  @override
  Future<Map<String, dynamic>> loginUserRemote(params) async {
    try {
      Map<String, dynamic> request = {
        'email': params.email,
        'password': params.password,
      };

      final response = await _dio.post("/auth/login", data: request);

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }
}

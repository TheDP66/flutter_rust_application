import 'package:InOut/core/utils/dio_provider.dart';
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

      print("data source register: $response");

      return response.data;
    } catch (e) {
      print("error register: $e");
      throw Exception(handleError(e));
    }
  }
}

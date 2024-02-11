import 'package:InOut/core/services/dio_provider.dart';
import 'package:InOut/core/utils/error.dart';
import 'package:InOut/data/datasources/user_remote_data_source.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;
  UserRemoteDataSourceImpl() : _dio = DioProvider().dio;

  @override
  Future<Map<String, dynamic>> meUserRemote() async {
    try {
      final response = await _dio.get("/api/users/me");

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }

  @override
  Future<Map<String, dynamic>> updatePhotoRemote(param) async {
    try {
      FormData formData = FormData.fromMap(param.toJson());

      final response = await _dio.post(
        "/api/users/me",
        data: formData,
      );

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }
}

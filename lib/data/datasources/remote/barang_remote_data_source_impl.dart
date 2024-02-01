import 'package:InOut/core/services/dio_provider.dart';
import 'package:InOut/core/utils/error.dart';
import 'package:InOut/data/datasources/barang_remote_data_source.dart';
import 'package:dio/dio.dart';

class BarangRemoteDataSourceImpl implements BarangRemoteDataSource {
  final Dio _dio;
  BarangRemoteDataSourceImpl() : _dio = DioProvider().dio;

  @override
  Future<Map<String, dynamic>> getBarangRemote(params) async {
    try {
      Map<String, dynamic> request = {
        'name': params.name,
      };

      final response = await _dio.get("/api/barang", queryParameters: request);

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }

  @override
  Future<Map<String, dynamic>> insertBarangRemote(params) {
    // TODO: implement insertBarangRemote
    throw UnimplementedError();
  }
}

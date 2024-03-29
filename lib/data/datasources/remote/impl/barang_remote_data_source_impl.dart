import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/services/dio_provider.dart';
import 'package:InOut/core/utils/error.dart';
import 'package:InOut/data/datasources/remote/barang_remote_data_source.dart';
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
  Future<Map<String, dynamic>> insertBarangRemote(params) async {
    try {
      Map<String, dynamic> request = {
        'name': params.name,
        'price': params.price,
        'stock': params.stock,
        'expired_at': params.expired_at!.isEmpty ? null : params.expired_at,
      };

      final response = await _dio.post("/api/barang", data: request);

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }

  @override
  Future<Map<String, dynamic>> syncBarangRemote(SyncBarangParams params) async {
    try {
      Map<String, dynamic> request = {
        'barang': params.barang,
      };

      final response = await _dio.post("/api/barang/sync", data: request);

      return response.data;
    } catch (e) {
      throw Exception(handleError(e));
    }
  }
}

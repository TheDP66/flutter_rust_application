import 'package:dio/dio.dart';
import 'package:flutter_rust_application/core/constant/url.dart';

class DioProvider {
  static final DioProvider _singleton = DioProvider._internal();

  late Dio _dio;

  factory DioProvider() {
    return _singleton;
  }

  DioProvider._internal() {
    // Initialize Dio with your base URL or other configurations
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
  }

  Dio get dio => _dio;
}

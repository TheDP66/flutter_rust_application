import 'dart:io';

import 'package:InOut/core/constant/url.dart';
import 'package:InOut/main.dart';
import 'package:InOut/presentation/pages/login_screen/login_screen.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  static final DioProvider _singleton = DioProvider._internal();
  late SharedPreferences prefs;

  late Dio _dio;

  factory DioProvider() {
    return _singleton;
  }

  void _logoutUser() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("token");

    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  DioProvider._internal() {
    // Initialize Dio with your base URL or other configurations
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        sendTimeout: const Duration(seconds: 6),
        connectTimeout: const Duration(seconds: 6),
        receiveTimeout: const Duration(seconds: 6),
        followRedirects: true,
        maxRedirects: 3,
        responseType: ResponseType.json,
        contentType: "application/json",
      ),
    );

    // ? for mobile or IOS
    if (kIsWeb) {
      _dio.httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
    } else if (Platform.isAndroid || Platform.isIOS) {
      // _dio.interceptors.add(CookieManager(CookieJar()));
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            _logoutUser();
          } else {
            _logoutUser();
          }

          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

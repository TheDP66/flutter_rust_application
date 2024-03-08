import 'dart:async';
import 'dart:developer';

import 'package:InOut/core/constant/url.dart';
import 'package:InOut/core/services/go_router.dart';
import 'package:InOut/data/models/token_model.dart';
import 'package:InOut/domain/entities/token_entity.dart';
// import 'package:dio/browser.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
    prefs.remove("access_token");
    prefs.remove("refresh_token");

    goRouter.pushReplacement("/login");
  }

  Future<String> _refreshToken() async {
    try {
      prefs = await SharedPreferences.getInstance();

      Response<Map<String, dynamic>> response = await dio.get(
        '/auth/refresh',
        data: {'refresh_token': prefs.getString("refresh_token")},
      );

      TokenEntity tokenEntity = TokenModel.fromJson(
        response.data!["data"],
      );

      if (tokenEntity.access_token == null) {
        throw Exception("Token expired, please relogin!");
      } else {
        prefs.setString("access_token", tokenEntity.access_token ?? "");

        return tokenEntity.access_token ?? "";
      }
    } catch (e) {
      _logoutUser();

      return "";
    }
  }

  DioProvider._internal() {
    // Initialize Dio with your base URL or other configurations
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        followRedirects: true,
        maxRedirects: 3,
        // responseType: ResponseType.json,
        // contentType: "application/json",
      ),
    );

    log("Run in web? $kIsWeb");

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final accessToken = await _refreshToken();

            error.requestOptions.headers["Cookie"] =
                "access_token=$accessToken";

            return handler.resolve(
              await dio.fetch(error.requestOptions),
            );
          } else if (error.response?.statusCode == 403) {
            _logoutUser();
          } else {
            return handler.next(error);
          }
        },
      ),
    );

    // TODO: choose one to use
    // ? for web
    if (kIsWeb) {
      // import 'package:dio/browser.dart';
      // _dio.httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
    } else {
      // ? for mobile or IOS
      _dio.interceptors.add(CookieManager(CookieJar()));
    }
  }

  Dio get dio => _dio;
}

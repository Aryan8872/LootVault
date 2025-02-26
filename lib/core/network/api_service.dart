import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/network/dio_error_interceptor.dart';
import 'package:loot_vault/core/network/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;
  final TokenSharedPrefs tokenSharedPrefs;

  Dio get dio => _dio;

  ApiService(this._dio, this.tokenSharedPrefs) {
    // Adding the TokenInterceptor to Dio
    _dio.interceptors.add(TokenInterceptor(
      tokenSharedPrefs: tokenSharedPrefs,
      dio: _dio,
    ));

    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.ConnectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ))
      ..options.headers = {
        'Accept': 'application/json',
      };
  }
}

import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/core/network/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ApiService {
  final Dio _dio;
  Dio get dio => _dio;

  ApiService(this._dio){
    _dio
        ..options.baseUrl = ApiEndpoints.baseUrl
        ..options.connectTimeout = ApiEndpoints.ConnectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
        ..interceptors.add(DioErrorInterceptor())
        ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true,responseHeader: true
        ))
        ..options.headers = {
          'Accept': 'application/json',
          // 'Content-Type': 'multipart/form-data'
        };

  }
}

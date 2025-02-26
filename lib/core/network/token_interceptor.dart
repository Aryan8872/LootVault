import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';


class TokenInterceptor extends Interceptor {
  final TokenSharedPrefs tokenSharedPrefs;
  final Dio dio;

  TokenInterceptor({
    required this.tokenSharedPrefs,
    required this.dio,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Retrieve the current token from shared preferences
    final tokenResult = await tokenSharedPrefs.getToken();
    String? token = tokenResult.getOrElse(() => '');

    if (token.isNotEmpty) {
      // Add token to the request headers
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh the token
      final refreshTokenResult = await tokenSharedPrefs.getUserData();
      final refreshToken = refreshTokenResult.getOrElse(() => {})['refreshToken'];

      if (refreshToken != null) {
        // Call refresh token API
        final refreshResponse = await dio.post(ApiEndpoints.refreshToken, data: {
          'refreshToken': refreshToken,
        });

        // Check if refresh token was successful
        if (refreshResponse.statusCode == 200) {
          final newToken = refreshResponse.data['token'];
          await tokenSharedPrefs.saveToken(newToken);

          // Retry the original request with the new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final retryRequest = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
          );

          return handler.resolve(retryRequest);
        }
      }
    }

    // If we can't refresh the token, pass the error along
    return super.onError(err, handler);
  }
}

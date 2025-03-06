import 'package:dio/dio.dart';
import 'package:loot_vault/core/error/failure.dart';

class SearchRemoteDataSource {
  final Dio _dio;

  SearchRemoteDataSource(this._dio);

  Future<Map<String, dynamic>> search({
    required String query,
    double? minPrice,
    double? maxPrice,
    List<String>? categories,
    List<String>? platforms,
    String? sortBy,
    String? order,
    String? type,
  }) async {
    try {
      // Build query parameters with default values
      final Map<String, dynamic> queryParams = {
        'q': query, // Ensure the query parameter is included
        if (minPrice != null) 'minPrice': minPrice.toString(),
        if (maxPrice != null) 'maxPrice': maxPrice.toString(),
        'category': categories?.join(',') ?? '', // Default to empty string
        'platform': platforms?.join(',') ?? '', // Default to empty string
        'sortBy': sortBy ?? 'gamePrice', // Default to 'gamePrice'
        'order': order ?? 'asc', // Default to 'asc'
        'type': type ?? 'both', // Default to 'both'
      };

      // Make the API call
      final uri = Uri.parse('http://192.168.1.64:3000/api/game/advanced-search').replace(queryParameters: queryParams);
      final response = await _dio.get(uri.toString());

      // Check the response status code
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Failure(message: 'Failed to fetch search results');
      }
    } on DioException catch (e) {
      throw ApiFailure(message: 'DioException: ${e.message}');
    } catch (e) {
      throw Failure(message: 'An error occurred: $e');
    }
  }
}
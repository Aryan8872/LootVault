import 'package:dio/dio.dart';
import 'package:loot_vault/app/constants/api_endpoints.dart';
import 'package:loot_vault/features/cart/data/data_source/cart_data_source.dart';
import 'package:loot_vault/features/cart/data/model/cart_api_model.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';

class CartRemoteDataSource implements ICartDataSource {
  final Dio _dio;

  CartRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<CartEntity>> addToCart(CartEntity entity) async {
    try {
      Response response = await _dio.post(ApiEndpoints.addCart, data: {
        "userId":entity.userId,
        "productId": entity.productId,
        "productName": entity.productName,
        "productPrice": entity.productPrice,
        "productImage": entity.productImage,
        "quantity": entity.quantity,
      });
      if (response.statusCode == 201) {
        Response cartResponse = await _dio.get(ApiEndpoints.getCart);

        // Parse the response into a list of CartApiModel objects
        if (cartResponse.statusCode == 200) {
          List<dynamic> cartData = cartResponse.data;
          List<CartApiModel> cartApiModels =
              cartData.map((item) => CartApiModel.fromJson(item)).toList();

          // Convert CartApiModel to CartEntity
          List<CartEntity> cartItems =
              cartApiModels.map((model) => model.toEntity()).toList();

          return cartItems;
        } else {
          throw Exception('Failed to fetch updated cart items');
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }



  @override
  Future<List<CartEntity>> getCartItems(String userId) async {
    try {
      Response cartResponse = await _dio.get('${ApiEndpoints.getCart}$userId');
      if (cartResponse.statusCode == 200) {
        List<dynamic> cartData = cartResponse.data['data'];
        List<CartApiModel> cartApiModels =
            cartData.map((item) => CartApiModel.fromJson(item)).toList();

        // Convert CartApiModel to CartEntity
        List<CartEntity> cartItems =
            cartApiModels.map((model) => model.toEntity()).toList();

        return cartItems;
      }else{
        throw Exception(cartResponse.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<void> clearCart(String userId) async{
   try {
      Response cartResponse = await _dio.delete('${ApiEndpoints.clearCart}$userId');
    
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}

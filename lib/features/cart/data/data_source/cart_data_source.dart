import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';

abstract interface class ICartDataSource {
  Future<List<CartEntity>> addToCart(CartEntity cartItem);
  Future<List<CartEntity>> getCartItems(String userId);
  Future<void> clearCart(String userId);

}

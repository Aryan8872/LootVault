import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';

abstract interface class ICartRepository {
  Future<Either<Failure, List<CartEntity>>> addToCart(CartEntity entity);
  Future<Either<Failure, List<CartEntity>>> getCrtItems(String userId);
  Future<Either<Failure, void>> clearCart(String userId);
}

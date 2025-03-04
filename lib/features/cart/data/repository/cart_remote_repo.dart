import 'package:dartz/dartz.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';
import 'package:loot_vault/features/cart/domain/repository/cart_repo.dart';

class CartRemoteRepo implements ICartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRemoteRepo({required this.cartRemoteDataSource});
  @override
  Future<Either<Failure, List<CartEntity>>> addToCart(CartEntity entity) async {
    try {
      final cartItems = await cartRemoteDataSource.addToCart(entity);
      return Right(cartItems);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCrtItems(String userId) async {
    try {
      final cartItems = await cartRemoteDataSource.getCartItems(userId);
      return Right(cartItems);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart(String userId) async {
    try {
      final cartItems = await cartRemoteDataSource.clearCart(userId);
      return Right(cartItems);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

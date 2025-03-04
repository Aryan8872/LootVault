import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';
import 'package:loot_vault/features/cart/domain/repository/cart_repo.dart';

class CartParams {
  final String userId;
  final String productId;
  final String productName;
  final double productPrice;
  final String productImage;
  final int quantity;

  CartParams(
      {required this.productId,
      required this.userId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.quantity});
}

class AddToCartUsecase implements UsecaseWithParams<void, CartParams> {
  final ICartRepository cartRepository;

  AddToCartUsecase({required this.cartRepository});
  @override
  Future<Either<Failure, List<CartEntity>>> call(CartParams params) async {
    return await cartRepository.addToCart(CartEntity(
        userId: params.userId,
        quantity: params.quantity,
        productId: params.productId,
        productImage: params.productImage,
        productName: params.productName,
        productPrice: params.productPrice));
  }
}

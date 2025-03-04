import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';
import 'package:loot_vault/features/cart/domain/repository/cart_repo.dart';

class ClearCartParams {
  final String userId;

  ClearCartParams({
    required this.userId,
  });
}

class ClearCartUsecase implements UsecaseWithParams<void, ClearCartParams> {
  final ICartRepository cartRepository;

  ClearCartUsecase({required this.cartRepository});
  @override
  Future<Either<Failure, void>> call(ClearCartParams params) async {
    return await cartRepository.clearCart(params.userId);
  }
}

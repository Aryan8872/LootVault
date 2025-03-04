import 'package:dartz/dartz.dart';
import 'package:loot_vault/app/usecase/usecase.dart';
import 'package:loot_vault/core/error/failure.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';
import 'package:loot_vault/features/cart/domain/repository/cart_repo.dart';

class GetCartParams {
  final String userId;

  GetCartParams({
    required this.userId,
  });
}

class GetCartItemsUsecase implements UsecaseWithParams<void, GetCartParams> {
  final ICartRepository cartRepository;

  GetCartItemsUsecase({required this.cartRepository});
  @override
  Future<Either<Failure, List<CartEntity>>> call(GetCartParams params) async {
    return await cartRepository.getCrtItems(params.userId);
  }
}

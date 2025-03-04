import 'package:bloc/bloc.dart';
import 'package:loot_vault/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:loot_vault/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:loot_vault/features/cart/domain/usecase/get_cart_items_usecase.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_event.dart';
import 'package:loot_vault/features/cart/presentation/view_model/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUsecase _addToCartUsecase;
  final GetCartItemsUsecase _getCartItemsUseCase;
    final ClearCartUsecase _clearCartUsecase;


  CartBloc({
    required AddToCartUsecase addToCartUsecase,
    required GetCartItemsUsecase getCartItemsUseCase,
        required ClearCartUsecase clearCartUsecase,
  })  : _addToCartUsecase = addToCartUsecase,
          _clearCartUsecase = clearCartUsecase,

        _getCartItemsUseCase = getCartItemsUseCase,
        super(const CartState.initial()) {
    on<AddToCartEvent>(_addToCart);
    on<GetCartItemsEvent>(_onGetCartItems);
    on<ClearCartEvent>(_clearCart);
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final result = await _addToCartUsecase.call(CartParams(
      userId: event.userId,
        productId: event.productId,
        productImage: event.productImage,
        productName: event.productName,
        productPrice: event.productPrice,
        quantity: event.quantity));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false)),
      (batches) {
        print("bloc ma succes ma gayo");
        emit(state.copyWith(
          isLoading: false,
        ));
      },
    );
  }

  Future<void> _onGetCartItems(GetCartItemsEvent event, Emitter<CartState>emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));

    final result = await _getCartItemsUseCase.call(GetCartParams(userId: event.userId));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false)),
      (batches) {
        print("bloc ma succes ma gayo");
        emit(state.copyWith(isLoading: false, cartItems: batches));
      },
    );
  }

  Future<void> _clearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _clearCartUsecase.call(ClearCartParams(userId: event.userId));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false)),
      (_) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          cartItems: const [],
        ));
      },
    );
  }
}

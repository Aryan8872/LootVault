import 'package:equatable/equatable.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';

class CartState extends Equatable {
  final String productId;
  final bool isLoading;
  final bool isSuccess;
  final String productName;
  final double productPrice;
  final String productImage;
  final int quantity;
  final List<CartEntity>? cartItems;

  const CartState(
      {required this.productId,
      required this.isLoading,
      this.cartItems,
      required this.isSuccess,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.quantity});

  const CartState.initial()
      : isLoading = false,
        isSuccess = false,
        productId = '',
        productImage = '',
        productPrice = 0,
        cartItems = const [],
        productName = '',
        quantity = 0;

  CartState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<CartEntity>? cartItems,
    String? productId,
    String? productName,
    double? productPrice,
    String? productImage,
    int? quantity,
  }) {
    return CartState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productPrice: productPrice ?? this.productPrice,
        cartItems: cartItems ?? this.cartItems,
        quantity: quantity ?? this.quantity,
        productImage: productImage ?? this.productImage);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        isLoading,
        isSuccess,
        cartItems,
        productId,
        productImage,
        productName,
        productPrice,
        quantity
      ];
}

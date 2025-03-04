import 'package:equatable/equatable.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String productId;
  final String userId;
  final String productName;
  final double productPrice;
  final String productImage;
  final int quantity;

  const AddToCartEvent(
      {required this.productId,
      required this.userId,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.quantity});
}

class GetCartItemsEvent extends CartEvent {
  final String userId;

  const GetCartItemsEvent({required this.userId});
}

class ClearCartEvent extends CartEvent {
  final String userId;

  const ClearCartEvent({required this.userId});
}

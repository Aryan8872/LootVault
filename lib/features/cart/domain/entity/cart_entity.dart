// features/cart/domain/entities/cart_entity.dart
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable{
  final String productId;
  final String productName;
  final String userId;
  final double productPrice;
  final String productImage;
  final int quantity;

  const CartEntity({
    required this.productId,
    required this.productImage,
    required this.userId,
    required this.productName,
    required this.productPrice,
    this.quantity = 1,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [productId,userId,productImage,productName,productPrice,quantity];
}
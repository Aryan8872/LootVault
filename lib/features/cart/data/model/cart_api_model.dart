import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loot_vault/features/cart/domain/entity/cart_entity.dart';

part 'cart_api_model.g.dart';

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String productId;
  final String userId;
  final String productName;
  final double productPrice;
  final String productImage;
  final int quantity;

  const CartApiModel(
      {required this.productId,
      required this.userId,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.quantity});

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  CartEntity toEntity() {
    return CartEntity(
        productId: productId,
        userId: userId,
        productImage: productImage,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity);
  }

  factory CartApiModel.fromEntity(CartEntity entity) {
    return CartApiModel(
      productId: entity.productId,
      productName: entity.productName,
      userId: entity.userId,
      productPrice: entity.productPrice,
      productImage: entity.productImage,
      quantity: entity.quantity,
    );
  }

  static List<CartEntity> toEntityList(List<CartApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props => [
        productId,
        productPrice,
        productName,
        productImage,
        quantity,
      ];
}

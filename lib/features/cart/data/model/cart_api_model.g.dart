// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      productId: json['_id'] as String,
      userId: json['userId'] as String,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      productImage: json['productImage'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'userId': instance.userId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'productImage': instance.productImage,
      'quantity': instance.quantity,
    };

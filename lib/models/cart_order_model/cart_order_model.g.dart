// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartOrderModelImpl _$$CartOrderModelImplFromJson(Map<String, dynamic> json) =>
    _$CartOrderModelImpl(
          productId: json['productId'] as String,
      producImage: (json['producImage'] as String?)?.toString() ?? '',
      productTitle: (json['productTitle'] as String?)?.toString() ?? '',
      productWeight: (json['productWeight'] as String?)?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      productPrice: (json['productPrice'] as String?)?.toString() ?? '',
      productMeta: json['productMeta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CartOrderModelImplToJson(
        _$CartOrderModelImpl instance) =>
    <String, dynamic>{
      'productId' : instance.productId,
      'producImage': instance.producImage,
      'productTitle': instance.productTitle,
      'productWeight': instance.productWeight,
      'quantity': instance.quantity,
      'price': instance.price,
      'productPrice': instance.productPrice,
      'productMeta': instance.productMeta,
    };

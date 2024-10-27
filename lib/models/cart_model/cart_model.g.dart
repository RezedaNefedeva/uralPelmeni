// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      productDetails: json['productDetails'] as String,
      productMeta: json['productMeta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productImages': instance.productImages,
      'quantity': instance.quantity,
      'discount': instance.discount,
      'productDetails': instance.productDetails,
      'productMeta': instance.productMeta,
    };

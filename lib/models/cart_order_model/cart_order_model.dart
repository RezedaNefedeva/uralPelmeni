import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cart_order_model.freezed.dart';
part 'cart_order_model.g.dart';

/// [Cart Model] for managing cart data

@freezed
class CartOrderModel with _$CartOrderModel {
  const factory CartOrderModel({
    required String productId,
    required String producImage,
    required String productTitle,
    required String productWeight,
    @Default(1) int quantity,
    @Default(0.0) double price,
    required String productPrice,
    Map<String, dynamic>? productMeta,
  }) = _CartOrderModel;


  factory CartOrderModel.fromJson(Map<String, Object?> json) =>
      _$CartOrderModelFromJson(json);
}
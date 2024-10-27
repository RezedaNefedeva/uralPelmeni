import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

/// [Cart Model] for managing cart data

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    required String productId,
    required String productName,
    List<String>? productImages,
    @Default(1) int quantity,
    @Default(0.0) double discount,
    required String productDetails,
    Map<String, dynamic>? productMeta,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, Object?> json) =>
      _$CartModelFromJson(json);
}
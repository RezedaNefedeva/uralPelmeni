// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartOrderModel _$CartOrderModelFromJson(Map<String, dynamic> json) {
  return _CartOrderModel.fromJson(json);
}

/// @nodoc
mixin _$CartOrderModel {
  String get productId => throw _privateConstructorUsedError;
  String? get producImage => throw _privateConstructorUsedError;
  String get productTitle => throw _privateConstructorUsedError;
  String get productWeight => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get productPrice => throw _privateConstructorUsedError;
  Map<String, dynamic>? get productMeta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartOrderModelCopyWith<CartOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartOrderModelCopyWith<$Res> {
  factory $CartOrderModelCopyWith(
          CartOrderModel value, $Res Function(CartOrderModel) then) =
      _$CartOrderModelCopyWithImpl<$Res, CartOrderModel>;
  @useResult
  $Res call(
      {String productId,
        String? producImage,
      String productTitle,
      String productWeight,
      int quantity,
      double price,
      String productPrice,
      Map<String, dynamic>? productMeta});
}

/// @nodoc
class _$CartOrderModelCopyWithImpl<$Res, $Val extends CartOrderModel>
    implements $CartOrderModelCopyWith<$Res> {
  _$CartOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? producImage = null,
    Object? productTitle = null,
    Object? productWeight = null,
    Object? quantity = null,
    Object? price = null,
    Object? productPrice = null,
    Object? productMeta = freezed,
  }) {
    return _then(_value.copyWith(
      producImage: null == producImage
          ? _value.producImage
          : producImage // ignore: cast_nullable_to_non_nullable
              as String,
      productTitle: null == productTitle
          ? _value.productTitle
          : productTitle // ignore: cast_nullable_to_non_nullable
              as String,
      productWeight: null == productWeight
          ? _value.productWeight
          : productWeight // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      productPrice: null == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as String,
      productMeta: freezed == productMeta
          ? _value.productMeta
          : productMeta // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartOrderModelImplCopyWith<$Res>
    implements $CartOrderModelCopyWith<$Res> {
  factory _$$CartOrderModelImplCopyWith(_$CartOrderModelImpl value,
          $Res Function(_$CartOrderModelImpl) then) =
      __$$CartOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
        String? producImage,
      String productTitle,
      String productWeight,
      int quantity,
      double price,
      String productPrice,
      Map<String, dynamic>? productMeta});
}

/// @nodoc
class __$$CartOrderModelImplCopyWithImpl<$Res>
    extends _$CartOrderModelCopyWithImpl<$Res, _$CartOrderModelImpl>
    implements _$$CartOrderModelImplCopyWith<$Res> {
  __$$CartOrderModelImplCopyWithImpl(
      _$CartOrderModelImpl _value, $Res Function(_$CartOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? producImage = null,
    Object? productTitle = null,
    Object? productWeight = null,
    Object? quantity = null,
    Object? price = null,
    Object? productPrice = null,
    Object? productMeta = freezed,
  }) {
    return _then(_$CartOrderModelImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
      as String,
      producImage: null == producImage
          ? _value.producImage
          : producImage // ignore: cast_nullable_to_non_nullable
              as String,
      productTitle: null == productTitle
          ? _value.productTitle
          : productTitle // ignore: cast_nullable_to_non_nullable
              as String,
      productWeight: null == productWeight
          ? _value.productWeight
          : productWeight // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      productPrice: null == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as String,
      productMeta: freezed == productMeta
          ? _value._productMeta
          : productMeta // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartOrderModelImpl
    with DiagnosticableTreeMixin
    implements _CartOrderModel {
  const _$CartOrderModelImpl(
      {required this.productId,
        required this.producImage,
      required this.productTitle,
      required this.productWeight,
      this.quantity = 1,
      this.price = 0.0,
      required this.productPrice,
      final Map<String, dynamic>? productMeta})
      : _productMeta = productMeta;

  factory _$CartOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartOrderModelImplFromJson(json);

  @override
  final String productId;
  @override
  final String producImage;
  @override
  final String productTitle;
  @override
  final String productWeight;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final double price;
  @override
  final String productPrice;
  final Map<String, dynamic>? _productMeta;
  @override
  Map<String, dynamic>? get productMeta {
    final value = _productMeta;
    if (value == null) return null;
    if (_productMeta is EqualUnmodifiableMapView) return _productMeta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CartOrderModel(productId: $productId, producImage: $producImage, productTitle: $productTitle, productWeight: $productWeight, quantity: $quantity, price: $price, productPrice: $productPrice, productMeta: $productMeta)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CartOrderModel'))
      ..add(DiagnosticsProperty('producImage', producImage))
      ..add(DiagnosticsProperty('productTitle', productTitle))
      ..add(DiagnosticsProperty('productWeight', productWeight))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('productPrice', productPrice))
      ..add(DiagnosticsProperty('productMeta', productMeta));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartOrderModelImpl &&
            (identical(other.producImage, producImage) ||
                other.producImage == producImage) &&
            (identical(other.productTitle, productTitle) ||
                other.productTitle == productTitle) &&
            (identical(other.productWeight, productWeight) ||
                other.productWeight == productWeight) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            const DeepCollectionEquality()
                .equals(other._productMeta, _productMeta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      producImage,
      productTitle,
      productWeight,
      quantity,
      price,
      productPrice,
      const DeepCollectionEquality().hash(_productMeta));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartOrderModelImplCopyWith<_$CartOrderModelImpl> get copyWith =>
      __$$CartOrderModelImplCopyWithImpl<_$CartOrderModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartOrderModelImplToJson(
      this,
    );
  }
}

abstract class _CartOrderModel implements CartOrderModel {
  const factory _CartOrderModel(
      {required String productId,
        required final String producImage,
      required final String productTitle,
      required final String productWeight,
      final int quantity,
      final double price,
      required final String productPrice,
      final Map<String, dynamic>? productMeta}) = _$CartOrderModelImpl;

  factory _CartOrderModel.fromJson(Map<String, dynamic> json) =
      _$CartOrderModelImpl.fromJson;

  @override
  String get productId;
  @override
  String get producImage;
  @override
  String get productTitle;
  @override
  String get productWeight;
  @override
  int get quantity;
  @override
  double get price;
  @override
  String get productPrice;
  @override
  Map<String, dynamic>? get productMeta;
  @override
  @JsonKey(ignore: true)
  _$$CartOrderModelImplCopyWith<_$CartOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

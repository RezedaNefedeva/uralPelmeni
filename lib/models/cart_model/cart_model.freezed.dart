// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return _CartModel.fromJson(json);
}

/// @nodoc
mixin _$CartModel {
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  List<String>? get productImages => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  String get productDetails => throw _privateConstructorUsedError;
  Map<String, dynamic>? get productMeta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartModelCopyWith<CartModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartModelCopyWith<$Res> {
  factory $CartModelCopyWith(CartModel value, $Res Function(CartModel) then) =
      _$CartModelCopyWithImpl<$Res, CartModel>;
  @useResult
  $Res call(
      {String productId,
      String productName,
      List<String>? productImages,
      int quantity,
      double discount,
      String productDetails,
      Map<String, dynamic>? productMeta});
}

/// @nodoc
class _$CartModelCopyWithImpl<$Res, $Val extends CartModel>
    implements $CartModelCopyWith<$Res> {
  _$CartModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? productImages = freezed,
    Object? quantity = null,
    Object? discount = null,
    Object? productDetails = null,
    Object? productMeta = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImages: freezed == productImages
          ? _value.productImages
          : productImages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      productDetails: null == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as String,
      productMeta: freezed == productMeta
          ? _value.productMeta
          : productMeta // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartModelImplCopyWith<$Res>
    implements $CartModelCopyWith<$Res> {
  factory _$$CartModelImplCopyWith(
          _$CartModelImpl value, $Res Function(_$CartModelImpl) then) =
      __$$CartModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      String productName,
      List<String>? productImages,
      int quantity,
      double discount,
      String productDetails,
      Map<String, dynamic>? productMeta});
}

/// @nodoc
class __$$CartModelImplCopyWithImpl<$Res>
    extends _$CartModelCopyWithImpl<$Res, _$CartModelImpl>
    implements _$$CartModelImplCopyWith<$Res> {
  __$$CartModelImplCopyWithImpl(
      _$CartModelImpl _value, $Res Function(_$CartModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? productImages = freezed,
    Object? quantity = null,
    Object? discount = null,
    Object? productDetails = null,
    Object? productMeta = freezed,
  }) {
    return _then(_$CartModelImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImages: freezed == productImages
          ? _value._productImages
          : productImages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      productDetails: null == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
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
class _$CartModelImpl with DiagnosticableTreeMixin implements _CartModel {
  const _$CartModelImpl(
      {required this.productId,
      required this.productName,
      final List<String>? productImages,
      this.quantity = 1,
      this.discount = 0.0,
      required this.productDetails,
      final Map<String, dynamic>? productMeta})
      : _productImages = productImages,
        _productMeta = productMeta;

  factory _$CartModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartModelImplFromJson(json);

  @override
  final String productId;
  @override
  final String productName;
  final List<String>? _productImages;
  @override
  List<String>? get productImages {
    final value = _productImages;
    if (value == null) return null;
    if (_productImages is EqualUnmodifiableListView) return _productImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final double discount;
  @override
  final String productDetails;
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
    return 'CartModel(productId: $productId, productName: $productName, productImages: $productImages, quantity: $quantity, discount: $discount, productDetails: $productDetails, productMeta: $productMeta)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CartModel'))
      ..add(DiagnosticsProperty('productId', productId))
      ..add(DiagnosticsProperty('productName', productName))
      ..add(DiagnosticsProperty('productImages', productImages))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('discount', discount))
      ..add(DiagnosticsProperty('productDetails', productDetails))
      ..add(DiagnosticsProperty('productMeta', productMeta));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartModelImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            const DeepCollectionEquality()
                .equals(other._productImages, _productImages) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.productDetails, productDetails) ||
                other.productDetails == productDetails) &&
            const DeepCollectionEquality()
                .equals(other._productMeta, _productMeta));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      productName,
      const DeepCollectionEquality().hash(_productImages),
      quantity,
      discount,
      productDetails,
      const DeepCollectionEquality().hash(_productMeta));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartModelImplCopyWith<_$CartModelImpl> get copyWith =>
      __$$CartModelImplCopyWithImpl<_$CartModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartModelImplToJson(
      this,
    );
  }
}

abstract class _CartModel implements CartModel {
  const factory _CartModel(
      {required final String productId,
      required final String productName,
      final List<String>? productImages,
      final int quantity,
      final double discount,
      required final String productDetails,
      final Map<String, dynamic>? productMeta}) = _$CartModelImpl;

  factory _CartModel.fromJson(Map<String, dynamic> json) =
      _$CartModelImpl.fromJson;

  @override
  String get productId;
  @override
  String get productName;
  @override
  List<String>? get productImages;
  @override
  int get quantity;
  @override
  double get discount;
  @override
  String get productDetails;
  @override
  Map<String, dynamic>? get productMeta;
  @override
  @JsonKey(ignore: true)
  _$$CartModelImplCopyWith<_$CartModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

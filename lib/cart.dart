import 'dart:async';
import 'dart:convert';
import 'package:flutter_cart/constants/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/models.dart';

class FlutterCart {
  static final FlutterCart _instance = FlutterCart._internal();
  late List<CartOrderModel> _cartOrderItemsList;
  late final SharedPreferences _sharedPreference;

  factory FlutterCart() {
    return _instance;
  }
  FlutterCart._internal();

  /// Set [isPersistenceSupportEnabled] to true to turn on the cart persistence
  /// Example:
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   var cart = FlutterCart();
  ///   await cart.initializeCart(isPersistenceSupportEnabled: true);
  ///   runApp(MyApp());
  /// }
  Future<void> initializeCart(
      {bool isPersistenceSupportEnabled = false}) async {
    _cartOrderItemsList = <CartOrderModel>[];
    _sharedPreference = await SharedPreferences.getInstance();
    await _enableAndDisableCartPersistenceSupport(
        isPersistenceSupportEnabled: isPersistenceSupportEnabled);
    if (isPersistenceSupportEnabled) {
      _cartOrderItemsList = _getPersistenceCartItems() ?? [];
    }
  }

  /// This method is called when we have to add an item to the cart
  /// Example:
  ///   void addToCart(YourProductModel product) {
  ///   flutterCart.addToCart(
  ///     cartModel: CartModel(
  ///       // ... other parameters
  ///       if [discount] is applicable and in percentage so, you can
  ///       calculate the discount like this
  ///       var discount = (product.discountPercentage / 100) * product.price;
  ///       discount: discount,
  ///       [productMeta] takes Map<String, dynamic> so, you can store your complete product data in productMeta
  ///       productMeta: product.toJson()),
  ///   );
  /// }
  void addToCart({required CartOrderModel cartOrderModel}) {
    var existingItemIndex = getProductIndex(cartOrderModel.productId);
    print('индекс элемента $existingItemIndex');

    if(existingItemIndex < _cartOrderItemsList.length){
      var quantity =
          _cartOrderItemsList[existingItemIndex].quantity + cartOrderModel.quantity;
      _cartOrderItemsList[existingItemIndex] =
          _cartOrderItemsList[existingItemIndex].copyWith(quantity: quantity);
    } else {
      _cartOrderItemsList.add(cartOrderModel);
    }
    if (getPersistenceSupportStatus()) {
      _updatePersistenceCart(_cartOrderItemsList);
    }
  }

  /// [updateQuantity] is used to increment/decrement the item quantity
  /// Example:
  ///  void updateQuantity(CartModel item, int newQuantity) {
  ///     flutterCart.updateQuantity(
  ///     item.productId, item.variants, newQuantity);
  /// }

  void updateQuantity(
      String productId, int newQuantity) {
    // if (newQuantity == 0) {
    //   removeItem(productId);
    // } else {
      var itemIndex = _cartOrderItemsList.indexWhere((item) =>
      item.productId == productId);

      if (itemIndex != -1) {
        _cartOrderItemsList[itemIndex] =
            _cartOrderItemsList[itemIndex].copyWith(quantity: newQuantity);
        if (getPersistenceSupportStatus()) {
          _updatePersistenceCart(_cartOrderItemsList);
        }
      }
    // }
  }

  /// [removeItem] is used for removing the specific item from the cart
  /// Example:
  // void removeItemFromCart(CartModel item) {
  //    flutterCart.removeItem(item.productId);
  //  }
  void removeItem(String productId) {
    _cartOrderItemsList.removeWhere((item) =>
    item.productId == productId);
    if (getPersistenceSupportStatus()) {
      _updatePersistenceCart(_cartOrderItemsList);
    }
  }

  /// [getSpecificProduct] will return the specific item from cart
  CartOrderModel getSpecificProduct(
      String productId,
      ) {
    var itemIndex = getProductIndex(productId);
      return _cartOrderItemsList[itemIndex];
  }

  /// [getProductIndex] will return the specific item index
  int getProductIndex(String productId,) {
    // var itemIndex = _cartOrderItemsList.indexWhere((item) =>
    // productId == item.productId);
    var itemIndex = int.parse(productId);

    return itemIndex;
  }

  /// [applyDiscount] use this method when you have case where you have to apply discount
  /// on specific product. Otherwise you can also apply discount the time of adding product into the cart.
  /// Check [addToCart] example for more info.
  void applyDiscount(
      String productId, double discount) {
    var itemIndex = getProductIndex(productId);

    if (itemIndex != -1) {
      _cartOrderItemsList[itemIndex] =
          _cartOrderItemsList[itemIndex].copyWith(price: discount);
    }
  }

  /// [clearCart] will clear the complete cart, including both in-memory and persistent cart data.
  void clearCart() {
    _cartOrderItemsList.clear();
    unawaited(_clearPersistenceCart());
  }

  /// [getPersistenceSupportStatus] use this method to check the persistence storage enable/disable status
  bool getPersistenceSupportStatus() {
    var status = _sharedPreference
        .getBool(SharedPreferenceConstants.isPersistenceSupportEnabled);
    return status ?? false;
  }

  //By default the persistence support will be off
  Future<void> _enableAndDisableCartPersistenceSupport(
      {required bool isPersistenceSupportEnabled}) async {
    try {
      await _sharedPreference.setBool(
        SharedPreferenceConstants.isPersistenceSupportEnabled,
        isPersistenceSupportEnabled,
      );
      if (!isPersistenceSupportEnabled) {
        await _clearPersistenceCart();
      }
    } catch (_) {
      rethrow;
    }
  }

  void _updatePersistenceCart(List<CartOrderModel> cartOrderItemsList) {
    var cartOrderList = cartOrderItemsList.map((e) => json.encode(e.toJson())).toList();
    unawaited(_sharedPreference.setStringList(
        SharedPreferenceConstants.persistCart, cartOrderList));
  }

  List<CartOrderModel>? _getPersistenceCartItems() {
    var items =
    _sharedPreference.getStringList(SharedPreferenceConstants.persistCart);
    if (items != null && items.isNotEmpty) {
      return items.map((e) => CartOrderModel.fromJson(json.decode(e))).toList();
    }
    return null;
  }

  Future<bool> _clearPersistenceCart() async {
    var isRemoved =
    await _sharedPreference.remove(SharedPreferenceConstants.persistCart);
    return isRemoved;
  }

  /// This method is called when we have to get the [Total amount]
  // double get subtotal {
  //   return _cartItemsList.fold(0, (sum, item) {
  //     return sum +
  //         item.variants.fold(
  //           0,
  //               (variantSum, variant) =>
  //           variantSum + (variant.price * item.quantity),
  //         );
  //   });
  // }

  double get total {
    return discount;
  }

  double get discount {
    return _cartOrderItemsList.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get cartLength {
    return _cartOrderItemsList.length;
  }

  List<CartOrderModel> get cartItemsList {
    return _cartOrderItemsList;
  }

  List<CartOrderModel>? get persistenceCartItemsList {
    return _getPersistenceCartItems();
  }
}
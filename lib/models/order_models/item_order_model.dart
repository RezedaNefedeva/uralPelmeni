class ItemOrderModel {
  final int index;
  final String productTitle;
  final int quantity;
  final double price;

  ItemOrderModel(this.index, this.productTitle, this.quantity, this.price);

  String itemToString() {
    return '\n$index: $productTitle, кол-во: $quantity, цена: $price';
  }
}
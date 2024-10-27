
import 'package:uralpelmen/features/cart/view/cart.dart';
import 'package:uralpelmen/features/catalog/catalog.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/bottomNav.dart';

class orderCart {

  void tapOnCart(int index){
    productPage.product_title = Cart.cartOrders.cartItemsList[index].productTitle;
    streamController.add(10);
    streamControllerBottom.add(2);
    productPage.backFrom = true;
  }

}
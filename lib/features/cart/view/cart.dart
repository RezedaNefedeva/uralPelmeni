
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/home/widgets/widgets.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/flutter_cart.dart';
import 'package:uralpelmen/models/models.dart';
import 'package:uralpelmen/theme/theme.dart';

import '../widgets/widgets.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  static CartOrderModel? cartOrder;

  static var cartOrders = FlutterCart();

  static void removeItemFromCart(CartOrderModel item){
    cartOrders.removeItem(item.productId);
  }

  static late OrderModel orderModel;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  int quantity = 1;

  late double total;

  late ItemOrderModel _orderModel;

  final List<String> _items_order = [];

  @override
  void initState() {
    total = Cart.cartOrders.discount;
    super.initState();
    SharedData.initName();
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    IconData icon = Icons.check_box_outline_blank;

    return
      Scaffold(
          backgroundColor: fon(),
          appBar: AppBar(
            backgroundColor: fon(),
              title: const HeaderAppBar(title: 'Корзина')),
          body: Stack(
              children: [
                if(Cart.cartOrders.cartLength == 0) Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('В корзине пока ничего нет', style: textTheme.textTheme.bodySmall,)]),
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: Cart.cartOrders.cartLength,
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: (){
                          setState(() {
                            orderCart().tapOnCart(index);
                          });
                        },
                        child:
                        Card(
                          margin: const EdgeInsets.all(10),
                          color: Colors.white,
                          shadowColor: yellow(),
                          elevation: 5,
                          child: SizedBox(
                              height: 120,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(padding: EdgeInsets.all(8.0)),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child:
                                        CachedNetworkImage(
                                          imageUrl: Cart.cartOrders.cartItemsList[index].producImage!,
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              Center(
                                                child: CircularProgressIndicator(
                                                  value: downloadProgress.progress,
                                                  color: yellow(),
                                                  strokeWidth: 2,),
                                              ),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(right: 8)),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width-166,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(child: Text(Cart.cartOrders.cartItemsList[index].productTitle,
                                                style: textTheme.textTheme.bodyLarge,
                                                maxLines: 2,
                                              )),
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    Cart.removeItemFromCart(Cart.cartOrders.cartItemsList[index]);
                                                    total = Cart.cartOrders.discount;
                                                  });
                                                },
                                                child: const Icon(Icons.delete_outline, size: 28,),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width-166,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(Cart.cartOrders.cartItemsList[index].productWeight, style: textTheme.textTheme.titleSmall,),
                                                  Text('${Cart.cartOrders.cartItemsList[index].productPrice} руб', style: textTheme.textTheme.bodyLarge,),
                                                ],
                                              ),
                                              Container(
                                                height: 48,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                    border: Border.all(color: yellow(), width: 2)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    IconButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            quantity = Cart.cartOrders.cartItemsList[index].quantity;
                                                            if(Cart.cartOrders.cartItemsList[index].quantity>1) quantity--;
                                                            Cart.cartOrders.updateQuantity(Cart.cartOrders.cartItemsList[index].productId, quantity);
                                                            total = Cart.cartOrders.discount;
                                                          });
                                                        },
                                                        icon: const Icon(Icons.remove, size: 32,)),
                                                    const SizedBox(width: 4,),
                                                    Text('${Cart.cartOrders.cartItemsList[index].quantity}', style: textTheme.textTheme.bodyLarge,),
                                                    const SizedBox(width: 4,),
                                                    IconButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            quantity = Cart.cartOrders.cartItemsList[index].quantity;
                                                            quantity++;
                                                            Cart.cartOrders.updateQuantity(Cart.cartOrders.cartItemsList[index].productId, quantity);
                                                            total = Cart.cartOrders.discount;
                                                          });
                                                        },
                                                        icon: const Icon(Icons.add, size: 32,)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],

                                    ),
                                  ]
                              )
                          ),
                        ),
                      ),
                ),
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: fon(),
                      child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Итого: ', style: textTheme.textTheme.bodySmall,),
                                  Text('$total руб', style: textTheme.textTheme.bodySmall,)
                                ]),
                                const SizedBox(height: 10,),
                                button(
                                    text: 'Оформить заказ',
                                    onTap: (){
                                      setState(() {
                                        if(Cart.cartOrders.cartLength == 0) {
                                          Fluttertoast.showToast(
                                              msg: "Мы не можем оформить пустую корзину. Предлагают добавить в нее вкусностей",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor: yellow(),
                                              textColor: Colors.black,
                                              fontSize: 16.0
                                          );
                                        } else {
                                          if(SharedData.showAlertDialog == ''){
                                            showDialog(
                                                context: context,
                                                builder: (context){
                                                  return AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    title: Text (
                                                      '"Уральские пельмени" это магазин домашней продукции.'
                                                          '\nМы не можем сделать четкий определенный вес на некоторые позиции (колбасы, мясо, купаты и т.п.), '
                                                          'поэтому сумма заказа в корзине является примерной. '
                                                          'Точную сумму мы Вам сообщим, когда заказ будет собран. '
                                                          '\nСпасибо за понимание', style: textTheme.textTheme.bodyLarge,),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          button(
                                                              text: 'Отмена',
                                                              onTap: (){
                                                                Navigator.pop(context);
                                                              },
                                                              width: MediaQuery.of(context).size.width/3,
                                                              height: 40,
                                                              img: 'assets/btn_des.png'),
                                                          button(
                                                              text: 'Я понимаю',
                                                              onTap: (){
                                                                for (int i = 0; i <
                                                                    Cart.cartOrders.cartLength; i++) {
                                                                  _orderModel = ItemOrderModel(
                                                                      i+1,
                                                                      Cart.cartOrders.cartItemsList[i]
                                                                          .productTitle,
                                                                      Cart.cartOrders.cartItemsList[i].quantity,
                                                                      Cart.cartOrders.cartItemsList[i].price);
                                                                  _items_order.add(_orderModel.itemToString());
                                                                }
                                                                Cart.orderModel = OrderModel(
                                                                    orderList: _items_order, total: total);
                                                                streamController.add(11);
                                                                streamControllerBottom.add(2);

                                                                Navigator.pop(context);
                                                              },
                                                              width: MediaQuery.of(context).size.width/3,
                                                              height: 40,
                                                              img: 'assets/btn_des.png'),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          button(
                                                              text: 'Больше не показывать',
                                                              onTap: (){
                                                                for (int i = 0; i <
                                                                    Cart.cartOrders.cartLength; i++) {
                                                                  _orderModel = ItemOrderModel(
                                                                      i+1,
                                                                      Cart.cartOrders.cartItemsList[i]
                                                                          .productTitle,
                                                                      Cart.cartOrders.cartItemsList[i].quantity,
                                                                      Cart.cartOrders.cartItemsList[i].price);
                                                                  _items_order.add(_orderModel.itemToString());
                                                                }
                                                                Cart.orderModel = OrderModel(
                                                                    orderList: _items_order, total: total);

                                                                SharedData.setShowAD('showAD');

                                                                streamController.add(11);
                                                                streamControllerBottom.add(2);

                                                                Navigator.pop(context);
                                                              },
                                                              width: MediaQuery.of(context).size.width/1.5,
                                                              height: 40,
                                                              img: 'assets/btn_des.png'),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            for (int i = 0; i <
                                                Cart.cartOrders.cartLength; i++) {
                                              _orderModel = ItemOrderModel(
                                                  i+1,
                                                  Cart.cartOrders.cartItemsList[i]
                                                      .productTitle,
                                                  Cart.cartOrders.cartItemsList[i].quantity,
                                                  Cart.cartOrders.cartItemsList[i].price);
                                              _items_order.add(_orderModel.itemToString());
                                            }
                                            Cart.orderModel = OrderModel(
                                                orderList: _items_order, total: total);
                                            streamController.add(11);
                                            streamControllerBottom.add(2);
                                          }
                                        }
                                      });
                                    },
                                    width: MediaQuery.of(context).size.width,
                                    height: 48,
                                    img: 'assets/btn_des.png')
                          ]
                      ),
                    )
                )
              ]
          )
      );
  }
}


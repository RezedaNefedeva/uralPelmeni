
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uralpelmen/features/cart/cart.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/features/catalog/catalog.dart';
import 'package:uralpelmen/models/models.dart';
import 'package:uralpelmen/theme/theme.dart';

class productCard extends StatefulWidget {
  const productCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.weight,
    required this.price});
  final String imageUrl;
  final String title;
  final String weight;
  final String price;

  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {

  late int counter;

  bool isFound = false;

  late CartOrderModel cartOrderModel;

  Future<void> loadImage(String imageUrl) async {
    try {
      // load network image example
      await precacheImage(NetworkImage(imageUrl), context);
    } catch (e) {
    }
  }


  @override
  Widget build(BuildContext context) {
    counter = 1;

    final textTheme = Theme.of(context);

    loadImage(widget.imageUrl);

    return InkWell(
      onTap: (){
        setState(() {
          productPage.product_title = widget.title;
          streamController.add(10);
          streamControllerBottom.add(1);
          productPage.backFrom = false;
        });
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: fonCard(),
        shadowColor: yellow(),
        elevation: 5,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)) ,
          ),
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                  width: 124,
                  height: 124,
                  child:
                  CachedNetworkImage(
                    imageUrl: widget.imageUrl,
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
              const SizedBox(width: 8,),
              Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 200,
                            child: Text(widget.title,
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              style: textTheme.textTheme.bodyLarge,)),
                        Container(
                          width: 200,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.weight, style: const TextStyle(fontFamily: 'Montserrat', color: Colors.black87, fontSize: 12),),
                                  Text('${widget.price} руб', style: textTheme.textTheme.bodyLarge,),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  cartOrderModel = CartOrderModel(
                                      productId: '${Cart.cartOrders.cartLength}',
                                      producImage: widget.imageUrl,
                                      productTitle: widget.title,
                                      productWeight: widget.weight,
                                      productPrice: widget.price,
                                      quantity: 1,
                                      price: double.tryParse(widget.price) ?? 0.0);
                                  setState(() {
                                    for(int i = 0; i < Cart.cartOrders.cartLength; i++ ){
                                      if(widget.title == Cart.cartOrders.cartItemsList[i].productTitle){
                                        isFound = true;
                                        Fluttertoast.showToast(
                                            msg: "Этот товар уже есть в корзине",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black87,
                                            textColor: yellow(),
                                            fontSize: 20.0);
                                      }
                                    }
                                    if(!isFound){
                                      Cart.cartOrders.addToCart(cartOrderModel: cartOrderModel);
                                      Fluttertoast.showToast(
                                          msg: "${widget.title} добавлен в корзину",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: yellow(),
                                          textColor: Colors.black87,
                                          fontSize: 16.0
                                      );
                                    }
                                  });

                                },
                                child: Container(
                                  width: 80,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(image: AssetImage('assets/btn_des.png'), fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                    child: const Image(image: AssetImage('assets/icons/cart.png'),)),
                              )
                            ],
                          ),
                        )
                      ],

                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}

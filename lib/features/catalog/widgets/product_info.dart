
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uralpelmen/features/cart/cart.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/features/recept/widgets/widgets.dart';
import 'package:uralpelmen/models/models.dart';
import 'package:uralpelmen/theme/theme.dart';

class productInfo extends StatefulWidget {
  const productInfo({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.weight,
    required this.price,
  });
  final String imageUrl;
  final String title;
  final String description;
  final String weight;
  final String price;

  @override
  State<productInfo> createState() => _productInfoState();
}

class _productInfoState extends State<productInfo> {

  // SharedOrderDataBase db = SharedOrderPrefs();

  late int counter = 1;

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
  void initState() {
    SharedData.initName();
    super.initState();
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    descriptionController.text = widget.description;
    priceController.text = widget.price;
    weightController.text = widget.weight;

    loadImage(widget.imageUrl);

    return SingleChildScrollView(
      child: Container(
        color: fon(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 60,),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 360,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                      ),
                      child:
                      // widget.imageUrl != '' ?
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Text(widget.title, style:  textTheme.textTheme.bodyMedium,),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(child: Text(widget.description, style: textTheme.textTheme.bodyLarge,))
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.weight, style: textTheme.textTheme.bodyLarge,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${widget.price}', style: textTheme.textTheme.bodyMedium,),
                                const SizedBox(width: 4,),
                                Text('руб', style: textTheme.textTheme.bodyLarge,)
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            button(
                                text: 'Купить',
                                onTap: (){
                                  cartOrderModel = CartOrderModel(
                                      productId: '${Cart.cartOrders.cartLength}',
                                      producImage: widget.imageUrl,
                                      productTitle: widget.title,
                                      productWeight: widget.weight,
                                      productPrice: widget.price,
                                      quantity: counter,
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
                                width: 180,
                                height: 54,
                                img: 'assets/btn_des.png'),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: yellow()),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          if(counter>1) {
                                            counter--;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.remove, color: Colors.black87,)),
                                  const SizedBox(width: 6,),
                                  Text('$counter', style: textTheme.textTheme.labelMedium,),
                                  const SizedBox(width: 6,),
                                  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          counter++;
                                        });
                                      },
                                      icon: const Icon(Icons.add, color: Colors.black87,)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40,),
              SharedData.userPhone == '89279589087' || SharedData.userPhone == '89823319788'?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Редактировать товар'),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20.0,),
                                            Text('Описание', style: textTheme.textTheme.displayMedium,),
                                            TextFieldRecept(
                                              hintText: 'Описание товара',
                                              controller: descriptionController,
                                              hintcolor: Colors.black,
                                            ),
                                            const SizedBox(height: 20.0,),
                                            Text('За какой вес цена', style: textTheme.textTheme.displayMedium,),
                                            TextFieldRecept(
                                              hintText: 'За какой вес цена',
                                              controller: weightController,
                                              hintcolor: Colors.black,
                                            ),
                                            const SizedBox(height: 20.0,),
                                            Text('Цена товара', style: textTheme.textTheme.displayMedium,),
                                            TextFieldRecept(
                                              hintText: 'Цена товара',
                                              controller: priceController,
                                              hintcolor: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      button(
                                          text: 'Отмена',
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          width: 100,
                                          height: 40,
                                          img: 'assets/btn-des.png'),
                                      button(
                                          text: 'Сохранить',
                                          onTap: (){
                                            FirebaseFirestore.instance.collection('products').doc(widget.title).update({

                                              'description' : descriptionController.text,
                                              'weight' : weightController.text,
                                              'price' : priceController.text,
                                            }
                                            );
                                            Navigator.pop(context);
                                          },
                                          width: 100,
                                          height: 40,
                                          img: 'assets/btn-des.png'),

                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.edit, color: Colors.black87)),
                      Text('Редактировать', style: textTheme.textTheme.bodyLarge,)
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Товар будет удален безвозвратно.\nУдалить?', style: textTheme.textTheme.bodySmall,),
                                    actions: [
                                      button(
                                          text: 'Отмена',
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          width: 100,
                                          height: 40,
                                          img: 'assets/btn-des.png'),
                                      button(
                                          text: 'Удалить',
                                          onTap: (){
                                            FirebaseFirestore.instance.collection('products').doc(widget.title).delete();
                                            Navigator.pop(context);
                                            streamController.add(9);
                                          },
                                          width: 100,
                                          height: 40,
                                          img: 'assets/btn-des.png'),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete_outline)),
                      Text('Удалить', style: textTheme.textTheme.bodyLarge,)
                    ],
                  ),

                ],
              ) :
              Text('', style: textTheme.textTheme.labelSmall,)
            ]
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:uralpelmen/features/catalog/widgets/product_info.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/theme/theme.dart';

class productPage extends StatefulWidget {
  const productPage({super.key});

  static String product_title = '';

  static bool backFrom = false;

  @override
  State<productPage> createState() => _productPageState();
}

class _productPageState extends State<productPage> {

  String description = '';
  String weight = '';
  String price = '';
  String imageUrl = '';

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    getInfo();
    initFirebase();
    super.initState();
    setState(() {
      productPage.product_title;
    });
  }

  Future getInfo() async {
    try {
      var collectionRef = await FirebaseFirestore.instance.collection('products').doc(productPage.product_title).get();
      setState(() {
        description = collectionRef['description'];
        imageUrl = collectionRef['image'];
        weight = collectionRef['weight'];
        price = collectionRef['price'];
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: fon(),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          } else if(!productPage.backFrom){
            streamController.add(1);
          } else if(productPage.backFrom){
            streamController.add(2);
          }
        }),
        child: productInfo(
            imageUrl: imageUrl,
            title: productPage.product_title,
            description: description,
            weight: weight,
            price: price),
      ),
    );
  }
}


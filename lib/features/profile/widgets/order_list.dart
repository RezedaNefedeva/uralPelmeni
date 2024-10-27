
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  int index = 0;
  String image = '';
  String title = '';
  String quantity = '';
  String price = '';

  Future getInfo() async {
    try {
      var collectionRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(SharedData.userPhone)
          .collection('orders')
          .doc('date')
          .collection('order_list')
          .doc('$index')
          .get();
      setState(() {
        index = collectionRef['index'];
        image = collectionRef['image'];
        title = collectionRef['title'];
        quantity = collectionRef['quantity'];
        price = collectionRef['price'];
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(SharedData.userPhone).collection('orders').orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: [
                    Text(snapshot.data!.docs[index]['order_list']['index']),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!.docs[index]['order_list']['image'],
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
                    Container(
                      width: 100,
                      child: Text(snapshot.data!.docs[index]['order_list']['title'], style: textTheme.textTheme.bodyLarge,),
                    ),
                    Container(
                      width: 40,
                      child: Text(snapshot.data!.docs[index]['order_list']['quantity'], style: textTheme.textTheme.bodyLarge,),
                    ),
                    Container(
                      width: 40,
                      child: Text(snapshot.data!.docs[index]['order_list']['price'], style: textTheme.textTheme.bodyLarge,),
                    ),
                  ],
                );
              });
        }
    );
  }
}

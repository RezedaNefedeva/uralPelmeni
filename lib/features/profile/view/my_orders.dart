
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uralpelmen/features/cart/cart.dart';
import 'package:uralpelmen/features/profile/view/view.dart';
import 'package:uralpelmen/features/profile/widgets/order_list.dart';
import 'package:uralpelmen/features/profile/widgets/shared_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/theme/theme.dart';
import '../../first_page/first_page.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  List my_orders = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Мои заказы', style: textTheme.textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          } streamController.add(4);
        }),
        child:
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(SharedData.userPhone).collection('orders').orderBy('date', descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) return const Text ('Вы пока ничего не заказывали');
              if (snapshot.hasError) {
                return const Text('Что-то пошло не так');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Загружается");
            }
            return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: fonCard(),
                      shadowColor: yellow(),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${index + 1}', style: textTheme.textTheme.labelLarge,),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Text('ДАТА:   ${snapshot.data!.docs[index]['date']}',
                                style: textTheme.textTheme.bodyLarge,),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Text('КОЛИЧЕСТВО ПОЗИЦИЙ:  ${snapshot.data!.docs[index]['items']}',
                                  style: textTheme.textTheme.bodyLarge,),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Text('ПРЕДВАРИТЕЛЬНАЯ СУММА:   ${snapshot.data!.docs[index]['total']}',
                              style: textTheme.textTheme.bodyLarge,),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Text('АДРЕС:   ${snapshot.data!.docs[index]['user_adress']}',
                              style: textTheme.textTheme.bodyLarge,),
                            TextButton(
                                onPressed: (){
                                  showModalBottomSheet(context: context,
                                      builder: (context){
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height,
                                          child: StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection('users').doc(SharedData.userPhone).collection('orders').doc('${snapshot.data!.docs[index]['date']}').collection('order_list').orderBy('index').snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                                return ListView.builder(
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (BuildContext context, int index){
                                                      return Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(snapshot.data!.docs[index]['index'], style: textTheme.textTheme.bodyLarge,),
                                                                const SizedBox(width: 10,),
                                                                ClipRRect(
                                                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                  child: SizedBox(
                                                                    width: 80,
                                                                    height: 80,
                                                                    child: CachedNetworkImage(
                                                                      imageUrl: snapshot.data!.docs[index]['image'],
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
                                                                const SizedBox(width: 10,),
                                                                Container(
                                                                  width: 160,
                                                                    child: Text(snapshot.data!.docs[index]['title'],
                                                                      style: textTheme.textTheme.bodyLarge,
                                                                      overflow: TextOverflow.fade,
                                                                      maxLines: 2,)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text(snapshot.data!.docs[index]['quantity'], style: textTheme.textTheme.bodyLarge,),
                                                                const SizedBox(width: 20,),
                                                                Text(snapshot.data!.docs[index]['price'], style: textTheme.textTheme.bodyLarge,),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }
                                          )
                                          // OrderList()
                                        );
                                      });
                                },
                                child: Text('Подробнее',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: yellow(),
                                      decoration: TextDecoration.underline),
                                ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
                }
            )
        ),
      );
  }
}
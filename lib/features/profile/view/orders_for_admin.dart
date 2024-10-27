
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uralpelmen/features/profile/widgets/shared_data.dart';
import 'package:uralpelmen/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uralpelmen/theme/theme.dart';
import '../../first_page/first_page.dart';

class OrdersForAdmin extends StatefulWidget {
  const OrdersForAdmin({super.key});

  @override
  State<OrdersForAdmin> createState() => _OrdersForAdminState();
}

class _OrdersForAdminState extends State<OrdersForAdmin> {

  List orders = [];

  String mtoken = '222';

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  void  getUserToken(String userPhone) async {
    var userToken = await FirebaseFirestore.instance.collection('userTokens').doc(userPhone).get();
      mtoken = userToken['token'];
  }

  TextEditingController newTotalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: fon(),
      appBar: AppBar(
        backgroundColor: fon(),
        title: Text('Все заказы', style: textTheme.textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          } streamController.add(7);
        }),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').orderBy('date', descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) return const Text ('Пока нет заказов');
            return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    color: grey(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text('${index + 1}', style: textTheme.textTheme.labelLarge,),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if(snapshot.data!.docs[index].get('status') == 'выполнен'){
                                      FirebaseFirestore.instance.collection('orders').doc(snapshot.data!.docs[index].id).delete();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Этот заказ еще не выполнен",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: yellow(),
                                          textColor: Colors.black87,
                                          fontSize: 20.0);
                                    }
                                  });
                                },
                                icon: const Icon(Icons.delete, color: Colors.white,))
                          ] ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Text('ДАТА: ${snapshot.data!.docs[index].id}', style: textTheme.textTheme.titleMedium,),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Text('ИМЯ: ${snapshot.data!.docs[index].get('user_name')}', style: textTheme.textTheme.titleMedium,),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('ТЕЛЕФОН:', style: textTheme.textTheme.titleMedium,),
                              const Padding(padding: EdgeInsets.only(right: 6)),
                              TextButton(
                                onPressed: (){
                                  launch('tel:${snapshot.data!.docs[index].get('user_phone')}');
                                },
                                child: Text('${snapshot.data!.docs[index].get('user_phone')}', style: textTheme.textTheme.displayMedium,),)
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Text('АДРЕС : ${snapshot.data!.docs[index].get('user_adress')}', style: textTheme.textTheme.titleMedium,),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Flexible(
                              child: Text('ЗАКАЗ : ${snapshot.data!.docs[index].get('order_list')}', style: textTheme.textTheme.titleMedium,)),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('ИТОГО НА СУММУ :', style: textTheme.textTheme.titleMedium,),
                              const Padding(padding: EdgeInsets.only(right: 6)),
                              TextButton(
                                onPressed: () {
                                  getUserToken('${snapshot.data!.docs[index].get('user_phone')}');
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Новая сумма заказа'),
                                        content: TextField(
                                          controller: newTotalController,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  FirebaseFirestore.instance.collection('orders').doc(snapshot.data!.docs[index].id).update(
                                                      {'total' : newTotalController.text});
                                                  FirebaseFirestore.instance.collection('users')
                                                      .doc('${snapshot.data!.docs[index].get('user_phone')}')
                                                      .collection('orders')
                                                      .doc(snapshot.data!.docs[index].id).update({
                                                    'total' : newTotalController.text
                                                  });
                                                });
                                                Navigator.of(ctx).pop();

                                                PushNotification.sendNotification(
                                                    mtoken,
                                                    context,
                                                    'Сумма заказа изменилась',
                                                  'К оплате ${newTotalController.text}'
                                                );
                                              },
                                              child: const Text('Изменить'))
                                        ],
                                      ));
                                },
                                child: Text(' ${snapshot.data!.docs[index].get('total')}  руб', style: textTheme.textTheme.displayMedium,),),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Text('${snapshot.data!.docs[index].get('cash_card')}', style: textTheme.textTheme.titleMedium,),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Flexible(child: Text('КОММЕНТАРИЙ: ${snapshot.data!.docs[index].get('comment')}', style: textTheme.textTheme.titleMedium,)),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('СТАТУС ЗАКАЗА:', style: textTheme.textTheme.titleMedium,),
                              const Padding(padding: EdgeInsets.only(right: 6)),
                              TextButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Заказ выполнен?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  FirebaseFirestore.instance.collection('orders').doc(snapshot.data!.docs[index].id).update(
                                                      {'status' : 'выполнен'});
                                                });
                                                Navigator.of(ctx).pop();
                                              },
                                              child: const Text('Да'))
                                        ],
                                      ));
                                },
                                child: Text('${snapshot.data!.docs[index].get('status')}', style: textTheme.textTheme.displayMedium,),),
                            ],
                          ),
                        ],
                      ),


                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }
}

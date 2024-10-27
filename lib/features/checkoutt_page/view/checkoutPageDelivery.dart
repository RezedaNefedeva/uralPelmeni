
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uralpelmen/features/checkoutt_page/widgets/text_form_fieald_auto.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/home/widgets/header_app_bar.dart';
import 'package:uralpelmen/features/profile/profile.dart';
import 'package:uralpelmen/features/profile/widgets/shared_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';
import '../../cart/cart.dart';
import '../../first_page/first_page.dart';
import '../../first_page/widgets/widgets.dart';
import 'package:uralpelmen/push_notification.dart';

class checkoutPage extends StatefulWidget {
  const checkoutPage({super.key});

  @override
  State<checkoutPage> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<checkoutPage> {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  String mtoken = '';
  String m2token = '';



  @override
  void initState() {
    super.initState();
    final messaging = FirebaseMessaging.instance;
    // LocalNotificationServices.initialize(flutterLocalNotificationsPlugin);
    requestPermission();
    adminToken();
    FirebaseMessaging.instance.getInitialMessage();
  }

  void requestPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert:  false,
      provisional: false,
      sound: true,
    );
  }

  void  adminToken() async {
    var adminToken = await FirebaseFirestore.instance.collection('userTokens').doc('89279589087').get();
    if(adminToken.exists){
      mtoken = adminToken['token'];
    }

    var admin2Token = await FirebaseFirestore.instance.collection('userTokens').doc('89823319788').get();
    if(admin2Token.exists){
      m2token = admin2Token['token'];
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool _validate_name = false;
  bool _validate_phone = false;
  bool _validate_adress = false;

  bool isCheckedCard = false;
  bool isCheckedCash = false;

  List<String> payment = [
    'Оплата наличными',
    'Оплата картой',
    'Не выбран способ оплаты'
  ];

  String _payment = '';

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  String date = DateTime.now().toString();

  int items = 0;

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    // _payment = payment[2];

    return Scaffold(
      backgroundColor: fon(),
      appBar: AppBar(backgroundColor: fon(),
          title: const HeaderAppBar(title: 'Оформление\nзаказа')),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          }
            streamController.add(2);
        }),
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 10,),
                  SharedData.userName != '' ?
                  TextFieldAuto(
                      hintText: 'Ваше имя',
                      textInputType: TextInputType.text,
                      controller: nameController,
                      hintcolor: !_validate_name ? Colors.black26 : yellow(),
                      helperText: !_validate_name ? '' : 'Поле не может быть пустым',
                      userData: SharedData.userName,
                      userDataText: AutofillHints.name)
                  : CustomTextField(
                      hintText: 'Ваше имя',
                      textInputType: TextInputType.text,
                      controller: nameController,
                      hintcolor: !_validate_name ? Colors.black26 : yellow(),
                      helperText: !_validate_name ? '' : 'Поле не может быть пустым'),
                  const SizedBox(height: 10,),
                  SharedData.userName != '' ?
                  TextFieldAuto(
                      hintText: 'Номер телефона',
                      textInputType: TextInputType.number,
                      controller: phoneController,
                      hintcolor: !_validate_phone ? Colors.black26 : yellow(),
                      helperText: !_validate_phone ? '' : 'Поле не может быть пустым',
                      userData: SharedData.userPhone,
                      userDataText: AutofillHints.telephoneNumber)
                  : CustomTextField(
                      hintText: 'Номер телефона',
                      textInputType: TextInputType.number,
                      controller: phoneController,
                      hintcolor: !_validate_phone ? Colors.black26 : yellow(),
                      helperText: !_validate_phone ? '' : 'Поле не может быть пустым'),
                  const SizedBox(height: 10,),
                  SharedData.userName != '' ?
                  TextFieldAuto(
                      hintText: 'Адрес',
                      textInputType: TextInputType.text,
                      controller: adressController,
                      hintcolor: !_validate_adress ? Colors.black26 : yellow(),
                      helperText: !_validate_adress ? '' : 'Поле не может быть пустым',
                      userData: SharedData.adressList,
                      userDataText: AutofillHints.fullStreetAddress)
                   : CustomTextField(
                      hintText: 'Адрес',
                      textInputType: TextInputType.text,
                      controller: adressController,
                      hintcolor: !_validate_adress ? Colors.black26 : yellow(),
                      helperText: !_validate_adress ? '' : 'Поле не может быть пустым'),
                  const SizedBox(height: 10,),
                  CustomTextFieldMultiline(
                      hintText: 'Комментарий к заказу',
                      controller: commentController,),
                  const SizedBox(height: 24,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Способ оплаты', style: textTheme.textTheme.labelMedium,)
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                                  (states) => const BorderSide(width: 1.0, color: Colors.black),
                            ),
                            fillColor: WidgetStateProperty.resolveWith(getColor),
                            value: isCheckedCard,
                            checkColor: yellow(),
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedCard = value!;
                                isCheckedCash = !value;
                                _payment = payment[1];
                              });
                            },
                          ),
                          Text('Онлайн перевод', style: textTheme.textTheme.bodyLarge,)
                        ]
                      ),
                      Row(
                          children: [
                            Checkbox(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                    (states) => const BorderSide(width: 1.0, color: Colors.black),
                              ),
                              fillColor: WidgetStateProperty.resolveWith(getColor),
                              value: isCheckedCash,
                              checkColor: yellow(),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedCash = value!;
                                  isCheckedCard = !value;
                                  _payment = payment[0];
                                });
                              },
                            ),
                            Text('Наличными при получении', style: textTheme.textTheme.bodyLarge,)
                          ]
                      ),
                      const SizedBox(height: 24,),
                      Column(
                        children: [
                          const Text('Предварительная сумма к оплате', textAlign: TextAlign.center, style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87)),
                          Text('${Cart.cartOrders.discount}', style: textTheme.textTheme.labelMedium,),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      button(
                          text: 'Отправить заказ',
                          onTap: () async {
                            if(nameController.text.isEmpty) {
                              setState(() {
                                _validate_name = true;
                              });

                            } else if(phoneController.text.isEmpty) {
                              setState(() {
                                _validate_phone = true;
                              });
                            } else if(adressController.text.isEmpty) {
                              setState(() {
                                _validate_adress = true;
                              });
                            } else {
                              setState(() {
                                String orderList = '${Cart.orderModel.orderList}';
                                FirebaseFirestore.instance.collection('orders').doc(date).set(
                                    {
                                      'date' : date,
                                      'user_phone': phoneController.text,
                                      'user_name': nameController.text,
                                      'user_adress' : adressController.text,
                                      'order_list' : orderList,
                                      'total' : Cart.orderModel.total,
                                      'cash_card' : _payment,
                                      'comment' : commentController.text,
                                      'status' : 'не выполнен'
                                    }
                                );
                                if(SharedData.userName.isNotEmpty && SharedData.userPhone.isNotEmpty) {

                                  for (int i = 0; i < Cart.cartOrders.cartLength; i++) {
                                    FirebaseFirestore.instance.collection('users')
                                        .doc(SharedData.userPhone)
                                        .collection('orders')
                                        .doc(date)
                                        .collection('order_list')
                                        .doc('${i + 1}')
                                        .set(
                                        {
                                          'index': '${i + 1}',
                                          'image': Cart.cartOrders.cartItemsList[i].producImage,
                                          'title': Cart.cartOrders.cartItemsList[i].productTitle,
                                          'quantity': '${Cart.cartOrders.cartItemsList[i].quantity}',
                                          'price': '${Cart.cartOrders.cartItemsList[i].price}',
                                        }
                                    );
                                    items = i+1;
                                  }
                                  FirebaseFirestore.instance.collection('users')
                                      .doc(SharedData.userPhone)
                                      .collection('orders')
                                      .doc(date)
                                      .set(
                                      {
                                        'date': date,
                                        'user_adress': adressController.text,
                                        'items' : '$items',
                                        'total': Cart.orderModel.total,
                                      }
                                  );
                                };

                                streamController.add(12);
                                streamControllerBottom.add(1);
                                Cart.cartOrders.clearCart();
                              });
                              PushNotification.sendNotification(mtoken, context, 'У вас новый заказ!', 'Срочно загляните в приложение, не заставляйте клиента ждать!');
                              PushNotification.sendNotification(m2token, context, 'У вас новый заказ!', 'Срочно загляните в приложение, не заставляйте клиента ждать!');
                            }
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          img: 'assets/btn_des.png'),
                      const SizedBox(height: 20,)
                    ],
                  ),

                ],
              ),
            ],
          ),
      ),
    );
  }
}

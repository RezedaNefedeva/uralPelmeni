
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/home/widgets/delivery_info.dart';
import 'package:uralpelmen/features/home/widgets/payment_info.dart';
import 'package:uralpelmen/features/home/widgets/contacts.dart';
import 'package:uralpelmen/theme/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image(image: AssetImage('assets/main_fon.png'), fit: BoxFit.fitWidth),),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const  EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:<Color>[Colors.transparent, grey()]
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Меня зовут Алексей.\nВсе товары, представленные в этом приложении, сделаны лично мной.\nЗа качество отвечаю!', style: text_theme.textTheme.titleMedium, textAlign: TextAlign.center,),
                    const SizedBox(height: 6,),
                    Text('Добро пожаловать!', style: text_theme.textTheme.titleLarge,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        button(
                          text: 'Оплата',
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                        gradient: LinearGradient(colors: [darkGrey(), grey()],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter),
                                        image: const DecorationImage(image: AssetImage('assets/container_des.png'), fit: BoxFit.fill)
                                    ),
                                    child: const payment_info(),
                                  );
                                }
                            );
                          },
                          width: MediaQuery.of(context).size.width/3.5,
                          height: 48,
                          img: 'assets/btn_des.png',),
                        button(
                          text: 'Доставка',
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        gradient: LinearGradient(colors: [darkGrey(), grey()],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter),
                                        image: const DecorationImage(image: AssetImage('assets/container_des.png'), fit: BoxFit.fill)
                                    ),
                                    child: const delivery_info(),
                                  );
                                }
                            );
                          },
                          width: MediaQuery.of(context).size.width/3.5,
                          height: 48,
                          img: 'assets/btn_des.png',),
                        button(
                          text: 'Контакты',
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        gradient: LinearGradient(colors: [darkGrey(), grey()],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter),
                                        image: const DecorationImage(image: AssetImage('assets/container_des.png'), fit: BoxFit.fill)
                                    ),
                                    child: const contacts(),
                                  );
                                }
                            );
                          },
                          width: MediaQuery.of(context).size.width/3.5,
                          height: 48,
                          img: 'assets/btn_des.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
        ],
      )

      );
  }
}



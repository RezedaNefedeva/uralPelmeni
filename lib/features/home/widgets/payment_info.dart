
import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';

class payment_info extends StatefulWidget {
  const payment_info({super.key});

  @override
  State<payment_info> createState() => _payment_infoState();
}

class _payment_infoState extends State<payment_info> {

  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Text('Оплата', style: text_theme.textTheme.labelLarge,),
              const SizedBox(height: 40,),
              Flexible(child: Text('Оплата при получении онлайн переводом на карту или наличными', style: text_theme.textTheme.titleMedium)),
              const SizedBox(height: 20,),
              Text('Для быстрого перевода, можно воспользоваться данным QR кодом', style: text_theme.textTheme.titleMedium),
              const SizedBox(height: 30,),
              Container(
                  width: 200,
                    height: 200,
                    child: const Image(image: AssetImage('assets/qrcod.jpeg'))),
            ],
          ),
        )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/features/home/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

class FinishPageDelivery extends StatefulWidget {
  const FinishPageDelivery({super.key});

  @override
  State<FinishPageDelivery> createState() => _FinishPageDeliveryState();
}

class _FinishPageDeliveryState extends State<FinishPageDelivery> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: AppBar(backgroundColor: fon(),)),
      backgroundColor: fon(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 280,
              height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(image: AssetImage('assets/logo.jpg'), fit: BoxFit.fill,)
                ),
                // child: const Image(image: AssetImage('assets/logo.jpg'), fit: BoxFit.fill,),
            ),
            const SizedBox(height: 40,),
            Text('Спасибо за Ваш заказ!', style: textTheme.textTheme.displayLarge, textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('В ближайшее время мы свяжемся с Вами по указанному телефону для уточнения суммы и деталей заказа',
                  style: textTheme.textTheme.bodyLarge, textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 40,),
            button(
                text: 'Продолжить покупки',
                onTap: (){
                  streamController.add(1);
                  streamControllerBottom.add(1);
                },
                width: MediaQuery.of(context).size.width*0.9,
                height: 60,
                img: 'assets/btn_des.png')
          ],
        ),
      ),
    );
  }
}

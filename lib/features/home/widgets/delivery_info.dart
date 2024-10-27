
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class delivery_info extends StatelessWidget {
  const delivery_info({super.key});

  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text('Доставка', style: text_theme.textTheme.labelLarge,),
            const SizedBox(height: 80,),
            Text('Доставка БЕСПЛАТНО', style: text_theme.textTheme.titleMedium),
            const SizedBox(height: 10,),
            Text('по правому берегу от 700 руб', style: text_theme.textTheme.titleMedium),
            const SizedBox(height: 10,),
            Text('по левому берегу от 1100 руб', style: text_theme.textTheme.titleMedium),
          ],
        ),
      )
     );
  }
}

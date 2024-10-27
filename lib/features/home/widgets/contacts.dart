
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telegram_link/telegram_link.dart';
import 'package:url_launcher/url_launcher.dart';

class contacts extends StatelessWidget {
  const contacts({super.key});

  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Text('Контакты', style: text_theme.textTheme.labelLarge,),
              const SizedBox(height: 80,),
              TextButton(
                  onPressed: (){
                    launch('tel:+79823319788');
                  },
                  child: Text('+7 982-331-97-88', style: text_theme.textTheme.titleLarge),),

              const SizedBox(height: 80,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkResponse(
                      enableFeedback: false,
                      onTap: () {
                        launch('tel:+79823319788');
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        child: const Image(
                          image: AssetImage('assets/phone.png'),
                        ),
                      )

                    ),
                    InkResponse(
                      enableFeedback: false,
                      onTap: () {
                        launch(TelegramLink(phoneNumber: '+79823319788').toString());
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        child: const Image(
                          image: AssetImage('assets/telegramm.png'),
                        ),
                      ),
                    ),
                    InkResponse(
                      enableFeedback: false,
                      onTap: () {
                        launch('whatsapp://send?phone=+79823319788');
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        child: const Image(
                          image: AssetImage('assets/whatsapp.png'),
                        ),
                      ),
                    ),
                  ]
              ),
            ],
          ),
        )
    );
  }
}
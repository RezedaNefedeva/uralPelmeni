
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';


class AuthOrReg extends StatefulWidget {
  const AuthOrReg({super.key});

  @override
  State<AuthOrReg> createState() => _AuthOrRegState();
}

class _AuthOrRegState extends State<AuthOrReg> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: (){
            setState(() {
              streamController.add(5);
              streamControllerBottom.add(4);
            });
          }
          ,
          child: const Text(
            'Авторизация', style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black38),
          ),
        ),
        TextButton(
          onPressed: (){
            setState(() {
              streamController.add(6);
              streamControllerBottom.add(4);
            });
          },

          child: Text(
            'Регистрация', style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: yellow(),
              decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

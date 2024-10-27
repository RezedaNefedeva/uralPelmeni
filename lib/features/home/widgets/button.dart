
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/theme/theme.dart';

class button extends StatelessWidget {
  button({
    super.key,
    required this.text,
    required this.onTap,
    required this.width,
    required this.height,
    required this.img

  });
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final String img;


  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(image: AssetImage(img),
            fit: BoxFit.fill),
          ),
            child: Center(
              child: Text(text, style: text_theme.textTheme.bodyLarge,),
            )
        ),

    );
  }
}



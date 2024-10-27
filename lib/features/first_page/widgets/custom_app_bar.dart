
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/theme/theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            child: Container(
              decoration: BoxDecoration(
                color: darkGrey(),
                image: const DecorationImage(
                  image: AssetImage('assets/appBarLogo.png'),

                ),
              ),
            )
        ),
      );
  }
}
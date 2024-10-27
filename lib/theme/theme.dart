import 'package:flutter/material.dart';


Color yellow(){
  return const Color(0xffFCB911);
}

Color fon(){
  return const Color(0xffededed);
}

Color fonCard(){
  return const Color(0xffffffff);
}

Color grey(){
  return const Color(0xff343434);
}

Color darkGrey(){
  return const Color(0xff191919);
}

final theme = ThemeData(
  textTheme:  TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'afuturicanord',
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: yellow()),
    bodyMedium: const TextStyle(
        fontFamily: 'afuturicanord',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black87),
    labelLarge: TextStyle(
        fontFamily: 'afuturicanord',
        fontSize: 24,
        fontWeight: FontWeight.w300,
        color: yellow()),
    displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: yellow()),
    displaySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: yellow()),
    titleLarge: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: Colors.white,),
    titleMedium: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white),
    titleSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: yellow()),
    labelSmall: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: Colors.white),
    bodyLarge: const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    ),
    bodySmall: const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20,
      fontWeight: FontWeight.w900,
      color: Colors.black87,
    ),
    labelMedium: const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
  ),
);


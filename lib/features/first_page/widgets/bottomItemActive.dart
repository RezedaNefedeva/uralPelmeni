
import 'dart:core';

import 'package:flutter/material.dart';

Column bottomItemActive (BuildContext context, String img){

  final textTheme = Theme.of(context);

  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.only(top: 4)),
        Image(
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            image: AssetImage(img)),
      ]
  );
}


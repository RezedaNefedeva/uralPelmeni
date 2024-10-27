

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

import '../first_page.dart';
import 'widgets.dart';

StreamController<int> streamControllerBottom = StreamController<int>();
StreamController<String> streamControllerBottomUser = StreamController<String>();

class bottomNav extends StatefulWidget {
  const bottomNav({super.key, required this.streamBottom, required this.streamBottomUser});
  final Stream <int> streamBottom;
  final Stream <String> streamBottomUser;

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  int indexNav = 0;

  String userName = '';

  @override
  void initState(){
    super.initState();
    widget.streamBottom.listen((index){
      getPageIndex(index);
    });
    widget.streamBottomUser.listen((name){
      getUserName(name);
    });
  }

  void getPageIndex(int index){
    setState(() {
      indexNav = index;
    });
  }

  void getUserName(String name){
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: grey(),
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(0);
                  indexNav = 0;
                });
              },
              child: indexNav == 0 ?
              bottomItemActive(context, 'assets/icons/house_active.png') :
              bottomItem(context, 'assets/icons/house.png', 'Главнаая')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(1);
                  indexNav = 1;
                });
              },
              child: indexNav == 1 ?
              bottomItemActive(context, 'assets/icons/catalog_activ.png') :
              bottomItem(context, 'assets/icons/catalog.png', 'Каталог')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(2);
                  indexNav = 2;
                });
              },
              child: indexNav == 2 ?
              bottomItemActive(context, 'assets/icons/cart_active.png') :
              bottomItem(context, 'assets/icons/cart.png', 'Корзина')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(3);
                  indexNav = 3;
                });
              },
              child: indexNav == 3 ?
              bottomItemActive(context, 'assets/icons/recept_active.png') :
              bottomItem(context, 'assets/icons/recept.png', 'Рецепты')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: () {
                if (SharedData.userName == '') {
                  setState(() {
                    streamController.add(5);
                    indexNav = 4;
                  });
                } else if (SharedData.userPhone == '89279589087' || SharedData.userPhone == '89823319788' || SharedData.userPhone == '+79279589087' || SharedData.userPhone == '+79823319788'){
                  setState(() {
                    streamController.add(7);
                    indexNav = 4;
                  });
                } else {
                  setState(() {
                    streamController.add(4);
                    indexNav = 4;
                  });
                }
              },
              child:indexNav == 4 ?
              bottomItemActive(context, 'assets/icons/profile_active.png') :
              bottomItem(context, 'assets/icons/profile.png', 'Профиль')
          )
        ],
      ),
    );
  }
}

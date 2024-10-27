import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uralpelmen/features/cart/cart.dart';
import 'package:uralpelmen/features/catalog/catalog.dart';
import 'package:uralpelmen/features/checkoutt_page/checkoutPage.dart';
import 'package:uralpelmen/features/finish_page/finish_page.dart';
import 'package:uralpelmen/features/first_page/widgets/custom_app_bar.dart';
import 'package:uralpelmen/features/home/home.dart';
import 'package:uralpelmen/features/profile/profile.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/features/recept/recept.dart';
import 'package:uralpelmen/theme/theme.dart';

import '../widgets/widgets.dart';

StreamController<int> streamController = StreamController<int>();
StreamController<String> streamControllerUser = StreamController<String>();

class FirstPage extends StatefulWidget {
  const FirstPage({super.key, required this.stream, required this.streamName});
  final Stream<int> stream;
  final Stream<String>streamName;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  int currentPageIndex = 0;

  @override
  void initState() {
    // SharedData.initName();
    super.initState();
    widget.stream.listen((index) {
      getIndexPage(index);
    });
  }

  final pages = [
    const Home(), //0
    const Catalog(), //1
    const Cart(), //2
    const Recept(), //3
    const Profile(), //4
    const Auth(), //5
    const Reg(), //6
    const AdminProfile(), //7
    const AddProduct(), //8
    const AllUsers(), //9
    const productPage(), //10
    const checkoutPage(), //11
    const FinishPageDelivery(),//12
    const OrdersForAdmin(), //13
    const MyOrders(), //14
    const MyData(), //15
    const ReceptPage(), //16
    const AddRecept(), //17
  ];

  void profilePage (){
    if(SharedData.userName == ''){
      currentPageIndex = 6;
    } else {
      currentPageIndex = 4;
    }
  }


  void getIndexPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: fon(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: pages[currentPageIndex],

      bottomNavigationBar: bottomNav(
        streamBottom: streamControllerBottom.stream,
        streamBottomUser: streamControllerBottomUser.stream,),
    );
  }

}

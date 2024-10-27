
import 'package:uralpelmen/features/cart/cart.dart';
import 'package:uralpelmen/features/catalog/catalog.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/profile/profile.dart';
import 'package:uralpelmen/features/recept/recept.dart';

final routes = {
  '/': (context) => FirstPage(stream: streamController.stream, streamName: streamControllerUser.stream,),
  '/cart': (context) => const Cart(),
  '/catalog': (context) => const Catalog(),
  '/profile': (context) => const Profile(),
  '/recepts': (context) => const Recept(),
};
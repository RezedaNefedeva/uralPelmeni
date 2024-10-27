
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uralpelmen/features/first_page/view/view.dart';
import 'package:uralpelmen/features/first_page/widgets/bottomNav.dart';
import 'package:uralpelmen/features/recept/widgets/recept_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/theme/theme.dart';

class ReceptPage extends StatefulWidget {
  const ReceptPage({super.key});
  static String recept_title = '';

  static bool backFrom = false;

  @override
  State<ReceptPage> createState() => _ReceptPageState();
}

class _ReceptPageState extends State<ReceptPage> {

  String description = '';
  String ingredient = '';
  String imageUrl = '';
  String author = '';

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    getInfo();
    initFirebase();
    super.initState();
    setState(() {
      ReceptPage.recept_title;
    });
  }

  Future getInfo() async {
    try {
      var collectionRef = await FirebaseFirestore.instance.collection('recepts').doc(ReceptPage.recept_title).get();
      setState(() {
        imageUrl = collectionRef['receptImage'];
        ingredient = collectionRef['receptIngredient'];
        author = collectionRef['author'];
        description = collectionRef['receptDescription'];
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: fon(),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          } else if (ReceptPage.backFrom) {
            streamController.add(0);
            streamControllerBottom.add(0);
          } else if (!ReceptPage.backFrom) {
            streamController.add(3);
            streamControllerBottom.add(3);
          }
        }),
        child: SingleChildScrollView(
          child: ReceptInfo(
              imageUrl: imageUrl,
              title: ReceptPage.recept_title,
              description: description,
              ingredients: ingredient,
              author: author),
        )
      ),
    );
  }
}

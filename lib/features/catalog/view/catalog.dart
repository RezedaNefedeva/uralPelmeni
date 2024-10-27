
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/home/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';
import 'package:uralpelmen/features/catalog/widgets/widgets.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {

  List category = [];

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    initFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: fon(),
      appBar: AppBar(backgroundColor: fon(),
          title: const HeaderAppBar(title: 'Каталог')),
      body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) {return
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text ('Проверьте интернет соединение', style: textTheme.textTheme.titleMedium,),
              );}
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index){
                    return productCard(
                      imageUrl: snapshot.data!.docs[index].get('image'),
                      title: snapshot.data!.docs[index].get('title'),
                      weight: snapshot.data!.docs[index].get('weight'),
                      price: snapshot.data!.docs[index].get('price'),);
                  }
              );
            },
          ),
      );
  }
}
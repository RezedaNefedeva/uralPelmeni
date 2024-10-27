
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/home/widgets/header_app_bar.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/features/recept/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

class Recept extends StatefulWidget {
  const Recept({super.key});

  @override
  State<Recept> createState() => _ReceptState();
}

class _ReceptState extends State<Recept> {
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
      appBar: AppBar(
          backgroundColor: fon(),
          title: const HeaderAppBar(title: 'Рецепты')),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          }
          streamController.add(0);
          streamControllerBottom.add(0);
        }),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('recepts').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) {return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text ('Проверьте интернет соединение', style: textTheme.textTheme.bodySmall,),
              );}
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return ReceptCard(
                    receptImage: snapshot.data!.docs[index].get('receptImage'),
                    receptTitle: snapshot.data!.docs[index].get('receptTitle'),
                    receptIngredient: snapshot.data!.docs[index].get('receptIngredient'),
                    author: snapshot.data!.docs[index].get('author'),
                  );
                },
              );
            }

        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(SharedData.userName == ''){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text('Добавлять рецепты могут только зарегистрированные и авторизованные пользователи.', style: textTheme.textTheme.bodyLarge,),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          button(
                              text: 'Авторизация',
                              onTap: (){
                                setState(() {
                                  streamController.add(5);
                                  streamControllerBottom.add(4);
                                  Navigator.pop(context);
                                });
                              },
                              width: 100,
                              height: 40,
                              img: 'assets/btn_des.png'),
                          button(
                              text: 'Регистрация',
                              onTap: (){
                                setState(() {
                                  streamController.add(6);
                                  streamControllerBottom.add(4);
                                  Navigator.pop(context);
                                });
                              },
                              width: 100,
                              height: 40,
                              img: 'assets/btn_des.png'),
                        ],
                      )
                    ],
                  );
                });
          } else {
            streamController.add(17);
            streamControllerBottom.add(3);
          }
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        label: const Text('Добавить рецепт', style: TextStyle(fontSize: 12, color: Colors.black87, fontFamily: 'Roboto'),),
        icon: const Icon(Icons.add, color: Colors.black87,),
        backgroundColor: yellow(),
      ),
    );
  }
}
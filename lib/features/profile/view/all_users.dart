
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/theme/theme.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {

  List allUsers = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
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
        title: Text('Все пользователи', style: textTheme.textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          } streamController.add(7);
        }),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) return Text ('У вас пока нет зарегистрированных пользователей', style: textTheme.textTheme.titleMedium,);
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    color: grey(),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            children: [
                              Text('${index + 1}', style: textTheme.textTheme.labelLarge,),
                              const Padding(padding: EdgeInsets.only(right: 20)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Имя: ${snapshot.data!.docs[index].get('name')}', style: textTheme.textTheme.displayMedium,),
                                  const Padding(padding: EdgeInsets.only(top: 6)),
                                  Text('Номер телефона: ${snapshot.data!.docs[index].id}', style: textTheme.textTheme.titleMedium,),
                                  const Padding(padding: EdgeInsets.only(top: 6)),
                                  Text('Email : ${snapshot.data!.docs[index].get('email')}', style: textTheme.textTheme.titleMedium,),
                                ],
                              ),
                            ]

                        )

                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }
}

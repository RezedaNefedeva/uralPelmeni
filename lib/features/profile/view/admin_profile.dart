
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/features/home/widgets/widgets.dart';
import 'package:uralpelmen/features/profile/profile.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  static String userNameProfile = '';
  static String userPhoneProfile = '';

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {

  @override
  void initState() {
    SharedData.initName();
    AdminProfile.userNameProfile;
    AdminProfile.userPhoneProfile = SharedData.userPhone;
    super.initState();
    getToken();
  }

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          saveToken(token!);
        }
    );
  }

  void saveToken(String token) async{
    await FirebaseFirestore.instance.collection('userTokens').doc(SharedData.userPhone).set({
      'token' : token,
    });

  }

  String userName(){
    if(AdminProfile.userNameProfile == ''){
      return "Рады Вас видеть, ${SharedData.userName}";
    } else {
      return "Рады Вас видеть, ${AdminProfile.userNameProfile}";
    }
  }

  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: fon(),
        appBar: AppBar(
          backgroundColor: fon(),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Flexible(child: Text(userName(),textAlign: TextAlign.center, style: text_theme.textTheme.labelMedium,)),
                const SizedBox(height: 40,),
                button(
                    text: 'Добавить товар',
                    onTap: (){
                        setState(() {
                          streamController.add(8);
                          streamControllerBottom.add(4);
                        });
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    img: 'assets/btn_des.png'),
                const SizedBox(height: 20,),
                button(
                    text: 'Все пользователи',
                    onTap: (){
                      setState(() {
                        streamController.add(9);
                        streamControllerBottom.add(4);
                      });
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    img: 'assets/btn_des.png'),
                const SizedBox(height: 20,),
                button(
                    text: 'Заказы',
                    onTap: (){
                      streamController.add(13);
                      streamControllerBottom.add(4);
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    img: 'assets/btn_des.png'),
                const SizedBox(height: 40,),
                TextButton(
                    onPressed: (){
                      setState(() {
                        SharedData.exitUser();
                        streamController.add(5);
                        streamControllerBottom.add(4);
                      });

                    },
                    child: Text('Выход', style: text_theme.textTheme.displaySmall,))
              ],
            )
        )
    );
  }
}


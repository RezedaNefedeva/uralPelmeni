
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/bottomNav.dart';
import 'package:uralpelmen/features/home/widgets/widgets.dart';
import 'package:uralpelmen/features/profile/widgets/text_field.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  static String userNameProfile = '';
  static String userPhoneprofile = '';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    SharedData.initName();
    Profile.userNameProfile;
    Profile.userPhoneprofile = SharedData.userPhone;
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
    if(Profile.userNameProfile == ''){
      return "Рады Вас видеть, ${SharedData.userName}";
    } else {
      return "Рады Вас видеть, ${Profile.userNameProfile}";
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
                  text: 'Мои заказы',
                  onTap: (){
                    streamController.add(14);
                    streamControllerBottom.add(4);
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  img: 'assets/btn_des.png'),
              const SizedBox(height: 20,),
              button(
                  text: 'Мои данные',
                  onTap: (){
                    streamController.add(15);
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


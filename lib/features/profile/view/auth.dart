
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/features/home/widgets/widgets.dart';
import 'package:uralpelmen/features/profile/profile.dart';
import 'package:uralpelmen/features/profile/widgets/shared_data.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    SharedData.initName();
  }

  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  late bool _validateAuth = false;

  late List<String> errorText = [
    '',
    'Номер телефона введен не корректно',
    'На этом номере телефона нет зарегистрированных пользователей. Зарегистрируйтесь или введите другой номер телефона',
    'Пароль не верный'
  ];


  late int indexText = 0;

  late String userName = '';

  bool docExists = false;

  bool passRight = false;

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = await FirebaseFirestore.instance.collection('users').doc(docId).get();
      if(collectionRef.exists){
        if(collectionRef['pass'] == userPassController.text){
          passRight = true;
          userName = collectionRef['name'];
        } else {
          passRight = false;
        }
        return docExists = true;
      } else {
        return docExists = false;
      }
    } catch (e) {
      rethrow;
    }
  }

  void _passRight(){
    if(userPhoneController.text == '89279589087' || userPhoneController.text == '89649624648'){
      setState(() {
        SharedData.setName(userName);
        SharedData.setPhone(userPhoneController.text);
        AdminProfile.userNameProfile = userName;
        streamController.add(7);
        streamControllerBottom.add(4);
      });
    } else {
      setState(() {
        SharedData.setName(userName);
        SharedData.setPhone(userPhoneController.text);
        Profile.userNameProfile = userName;
        streamController.add(4);
        streamControllerBottom.add(4);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final text_theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: fon(),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: AppBar(backgroundColor: fon(),)),
      body: SingleChildScrollView(
        child: Stack(
              children: [Container(
                height: MediaQuery.of(context).size.height-240,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text('Авторизация', style: text_theme.textTheme.labelLarge),
                      const SizedBox(height: 40,),
                      CustomTextField(
                        hintText: 'Номер телефона',
                        textInputType: TextInputType.number,
                        controller: userPhoneController,
                        hintcolor: !_validateAuth ? Colors.black87 : Colors.redAccent,
                        helperText: !_validateAuth ? '' : 'Поле не может быть пустым',
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        hintText: 'Пароль',
                        textInputType: TextInputType.visiblePassword,
                        controller: userPassController,
                        hintcolor: !_validateAuth ? Colors.black87 : Colors.redAccent,
                        helperText: !_validateAuth ? '' : 'Поле не может быть пустым',
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          backgroundColor: fon(),
                                          title: Text('Смена пароля', style: text_theme.textTheme.displayMedium,),
                                          content: Container(
                                            color: fon(),
                                            height: 140,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  onChanged: (value) {
                                                    setState(() {
                                                      userPhoneController.text = value;
                                                    });
                                                  },
                                                  controller: userPhoneController,
                                                  keyboardType: TextInputType.number,
                                                  decoration:
                                                  const InputDecoration(
                                                      hintText: 'Номер телефона',
                                                      hintStyle: TextStyle(color: Colors.black45)),
                                                ),
                                                const SizedBox(height: 6,),
                                                TextField(
                                                  onChanged: (value) {
                                                    setState(() {
                                                      newPassController.text = value;
                                                    });
                                                  },
                                                  controller: newPassController,
                                                  decoration:
                                                  const InputDecoration(
                                                    hintText: 'Новый пароль',
                                                    hintStyle: TextStyle(color: Colors.black45,),
                                                ),
                                                )
                                              ],
                                            ),
                                          ),
        
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                button(
                                                    text: 'Отмена',
                                                    onTap: (){
                                                      setState(() {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    width: 110,
                                                    height: 40,
                                                    img: 'assets/btn_des.png'),
                                                button(
                                                    text: 'Изменить',
                                                    onTap: () async {
                                                      await checkIfDocExists(userPhoneController.text);
                                                      if (docExists) {
                                                        setState(() {
                                                          FirebaseFirestore.instance
                                                              .collection('users')
                                                              .doc(
                                                              userPhoneController.text)
                                                              .update({
                                                            'pass': newPassController.text
                                                          }
                                                          );
                                                          Navigator.pop(context);
                                                        });
                                                      }  else {
                                                        setState(() {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context){
                                                                return AlertDialog(
                                                                  backgroundColor: fon(),
                                                                  title: Text('Номер телефона не зарегистрирован. Перейти на страницу регистрации?.', style: text_theme.textTheme.displaySmall,),
                                                                  actions: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        button(
                                                                            text: 'Отмена',
                                                                            onTap: (){
                                                                              setState(() {
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            width: 110,
                                                                            height: 40,
                                                                            img: 'assets/btn_des.png'),
                                                                        button(
                                                                            text: 'Перейти',
                                                                            onTap: (){
                                                                              setState(() {
                                                                                streamController.add(6);
                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            width: 110,
                                                                            height: 40,
                                                                            img: 'assets/btn_des.png'),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                          );
                                                        });
                                                      }
        
                                                    },
                                                    width: 110,
                                                    height: 40,
                                                    img: 'assets/btn_des.png')
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                  );
                                },
                                child: SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Text('Забыли пароль', style: text_theme.textTheme.titleSmall,))),]
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        errorText[indexText], style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 20,),
                      button(
                        text: 'Авторизоваться',
                        onTap: () async {
                          if(userPhoneController.text.isEmpty || userPassController.text.isEmpty){
                            setState(() {
                              _validateAuth = true;
                            });
                          } else if (userPhoneController.text.length<11 || userPhoneController.text.length>12){
                            setState(() {
                              indexText = 1;
                            });
                          } else {
                            await checkIfDocExists(userPhoneController.text);
                            if (docExists) {
                              if(passRight){
                                _passRight();
                              } else {
                                setState(() {
                                  indexText = 3;
                                });
                              }
                            }  else {
                              setState(() {
                                indexText = 2;
                              });
                            }
                          }
                        },
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        img: 'assets/btn_des.png',)
                    ],
                  ),
                ),
              ),
                const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: RegAuth())]
          ),
      ),
      );
  }
}


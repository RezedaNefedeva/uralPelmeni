
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/first_page/widgets/widgets.dart';
import 'package:uralpelmen/features/home/widgets/widgets.dart';
import 'package:uralpelmen/features/profile/profile.dart';
import 'package:uralpelmen/features/profile/widgets/text_field.dart';
import 'package:uralpelmen/features/profile/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';

class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    SharedData.initName();
  }

  final userPhoneController = TextEditingController();
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPassController = TextEditingController();

  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signUpRequired = false;
  bool contains7length = false;

  late bool _validateName = false;
  late bool _validatePhone = false;
  late bool _validateEmail = false;
  late bool _validatePass = false;

  late List<String> errorText = [
    '',
    'Номер телефона введен не корректно',
    'Email введен не верно',
    'Номер уже используется',
    'Не надежный пароль. Придумайте пароль не менее 7 символов'
  ];


  late int indexText = 0;

  bool docExists = false;

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = await FirebaseFirestore.instance.collection('users').doc(docId).get();
      if(collectionRef.exists){
        return docExists = true;
      } else {
        return docExists = false;
      }
    } catch (e) {
      rethrow;
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
                        Text('Регистрация', style: text_theme.textTheme.labelLarge),
                        const SizedBox(height: 20,),
                        CustomTextField(
                          hintText: 'Имя',
                          textInputType: TextInputType.text,
                          controller: userNameController,
                          hintcolor: !_validateName ? Colors.black87 : Colors.redAccent,
                          helperText: !_validateName ? '' : 'Поле не может быть пустым',
                        ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          hintText: 'Номер телефона',
                          textInputType: TextInputType.number,
                          controller: userPhoneController,
                          hintcolor: !_validatePhone ? Colors.black87 : Colors.redAccent,
                          helperText: !_validatePhone ? '' : 'Поле не может быть пустым',
                        ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          controller: userEmailController,
                          hintcolor: !_validateEmail ? Colors.black87 : Colors.redAccent,
                          helperText: !_validateEmail ? '' : 'Поле не может быть пустым',
                        ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          hintText: 'Пароль',
                          textInputType: TextInputType.visiblePassword,
                          controller: userPassController,
                          hintcolor: !_validatePass ? Colors.black87 : Colors.redAccent,
                          helperText: !_validatePass ? '' : 'Поле не может быть пустым',
                        ),
                        Text(errorText[indexText], style: text_theme.textTheme.titleSmall,),
                        const SizedBox(height: 20,),
                        !signUpRequired ?
                        button(
                          text: 'Зарегистрироваться',
                          onTap: () async {
                            if(userNameController.text.isEmpty){
                              setState(() {
                                _validateName = true;
                              });
                            } else if(userPhoneController.text.isEmpty){
                              setState(() {
                                _validatePhone = true;
                              });
                            } else if(userEmailController.text.isEmpty){
                              setState(() {
                                _validateEmail = true;
                              });
                            } else if(userPassController.text.isEmpty){
                              setState(() {
                                _validatePass = true;
                              });
                            } else if(userPhoneController.text.length!=11){
                              setState(() {
                                indexText = 1;
                              });
                            } else if (!userEmailController.text.contains('@')&&!userEmailController.text.contains('.')){
                              setState(() {
                                indexText = 2;
                              });
                            } else if (userPassController.text.length<7){
                              setState(() {
                                indexText = 4;
                              });
                            } else {
                              await checkIfDocExists(userPhoneController.text);
                              if (docExists) {
                                setState(() {
                                  indexText = 3;
                                });
                              } else {
                                FirebaseFirestore.instance.collection('users').doc(
                                    userPhoneController.text).set(
                                    {'name': userNameController.text,
                                      'email': userEmailController.text,
                                      'pass': userPassController.text,
                                    });
                                setState(() {
                                  if(userPhoneController.text == '89279589087' || userPhoneController.text == '89823319788' || userPhoneController.text == '+79279589087' || userPhoneController.text == '+79823319788'){
                                    setState(() {
                                      SharedData.setName(userNameController.text);
                                      SharedData.setPhone(userPhoneController.text);
                                      AdminProfile.userNameProfile = userNameController.text;
                                      print(AdminProfile.userNameProfile);
                                      streamController.add(7);
                                      streamControllerBottom.add(4);
                                    });
                                  } else {
                                    setState(() {
                                      SharedData.setName(userNameController.text);
                                      SharedData.setPhone(userPhoneController.text);
                                      SharedData.setEmail(userEmailController.text);
                                      Profile.userNameProfile = userNameController.text;
                                      streamController.add(4);
                                      streamControllerBottom.add(4);
                                    });
                                  }
                                });
                              }
                            }
                  
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          img: 'assets/btn_des.png',)
                            :
                          const CircularProgressIndicator(),
                        const SizedBox(height: 40,)
                      ],
                    ),
                  ),
                              ),
              const Positioned(
                bottom: 0,
                  left: 0,
                  right: 0,
                  child: AuthOrReg())]
            ),
      ),
      );
  }
}


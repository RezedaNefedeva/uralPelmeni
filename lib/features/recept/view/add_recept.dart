
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uralpelmen/features/first_page/widgets/custom_app_bar.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/home/widgets/header_app_bar.dart';
import 'package:uralpelmen/features/profile/widgets/get_image.dart';
import 'package:uralpelmen/features/profile/widgets/text_field.dart';
import 'package:uralpelmen/features/recept/widgets/widgets.dart';
import 'package:uralpelmen/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../first_page/first_page.dart';
import '../../profile/widgets/shared_data.dart';

class AddRecept extends StatefulWidget {
  const AddRecept({super.key});

  @override
  State<AddRecept> createState() => _AddReceptState();
}

class _AddReceptState extends State<AddRecept> {

  int index = 0;

  TextEditingController receptTitleController  = TextEditingController();
  TextEditingController receptIngredientController  = TextEditingController();
  TextEditingController receptDescriptionController  = TextEditingController();

  final bool _validate = false;

  bool _isLoading = false;

  String btn_text = 'Добавить';

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    String imgURL = '';

    Future uploadImg(BuildContext context) async {
      setState(() {
        _isLoading = true;
      });
      String fileName = receptTitleController.text;
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('recepts');
      Reference uploadRef = firebaseStorageRef.child(fileName);
      try{
        final uploatTask = await uploadRef.putFile(File(getImage.image!.path));
        setState(() async {
          imgURL = await (uploatTask).ref.getDownloadURL();
          FirebaseFirestore.instance.collection('recepts').doc(
              receptTitleController.text).set(
              {'receptTitle': receptTitleController.text,
                'receptImage': imgURL,
                'receptIngredient': receptIngredientController.text,
                'receptDescription': receptDescriptionController.text,
                'author' : SharedData.userName
              });
          setState(() {
            _isLoading = false;
            btn_text = 'Рецепт добавлен';
            receptTitleController.clear();
            receptIngredientController.clear();
            receptDescriptionController.clear();
          });
        });
      } catch (error){
      }
    }

    return Scaffold(
      backgroundColor: fon(),
      appBar: AppBar(title: const HeaderAppBar(title: 'Добавить рецепт')),
      body: Scaffold(
        backgroundColor: fon(),
        body: PopScope(
          canPop: false,
          onPopInvoked: ((didpop){
            if(didpop){
              return;
            } streamController.add(3);
          }),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0,),
                Text('Выбрать изображение рецепта', style: textTheme.textTheme.displayMedium,),
                const getImage(),
                const SizedBox(height: 20.0,),
                Text('Название рецепта', style: textTheme.textTheme.displayMedium,),
                CustomTextField(
                    hintText: 'Введите название рецепта',
                    textInputType: TextInputType.text,
                    controller: receptTitleController,
                    hintcolor: !_validate?Colors.black:yellow(),
                    helperText: ''),
                const SizedBox(height: 20.0,),
                Text('Ингредиенты', style: textTheme.textTheme.displayMedium,),
                TextFieldRecept(
                    hintText: 'Введите название и количество ингредиентов',
                    controller: receptIngredientController,
                    hintcolor: !_validate?Colors.black:yellow(),
                ),
                const SizedBox(height: 40.0,),
                Text('Описание рецепта', style: textTheme.textTheme.displayMedium,),
                TextFieldRecept(
                    hintText: 'Напишите свой рецепт',
                    controller: receptDescriptionController,
                    hintcolor: !_validate?Colors.black:yellow(),
                ),
                const SizedBox(height: 40.0,),
                _isLoading ?
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: yellow(),
                    strokeWidth: 2,
                  ),
                ) :
                button(
                    text: btn_text,
                    onTap: () async {
                      await uploadImg(context);
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    img: 'assets/btn_des.png'),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uralpelmen/features/first_page/first_page.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/profile/widgets/get_image.dart';
import 'package:uralpelmen/features/profile/widgets/text_field.dart';
import 'package:uralpelmen/theme/theme.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController productTitleController  = TextEditingController();
  TextEditingController productDescriptionController  = TextEditingController();
  TextEditingController productWeightController  = TextEditingController();
  TextEditingController productPriceController  = TextEditingController();

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
      String fileName = productTitleController.text;
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('products');
      Reference uploadRef = firebaseStorageRef.child(fileName);
      try{
        final uploatTask = await uploadRef.putFile(File(getImage.image!.path));
        setState(() async {
          imgURL = await (uploatTask).ref.getDownloadURL();
          FirebaseFirestore.instance.collection('products').doc(
              productTitleController.text).set(
              {'title': productTitleController.text,
                'image': imgURL,
                'description': productDescriptionController.text,
                'weight': productWeightController.text,
                'price': productPriceController.text});
          setState(() {
            _isLoading = false;
            btn_text = 'Продукт добавлен';
            productTitleController.clear();
            productPriceController.clear();
            productWeightController.clear();
            productDescriptionController.clear();
          });
        });
      } catch (error){
      }
    }

    return Scaffold(
      backgroundColor: fon(),
        appBar: AppBar(
          backgroundColor: fon(),
          title: Text('\nДобавить товар\n', style: textTheme.textTheme.labelLarge,),
          centerTitle: true,
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: ((didpop){
            if(didpop){
              return;
            } streamController.add(7);
          }),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0,),
                Text('Выбрать изображение продукта', style: textTheme.textTheme.bodyLarge,),
                const SizedBox(height: 20.0,),
                const getImage(),
                const SizedBox(height: 20.0,),
                Text('Название продукта', style: textTheme.textTheme.bodyLarge,),
                CustomTextField(
                    hintText: '',
                    textInputType: TextInputType.text,
                    controller: productTitleController,
                    hintcolor: !_validate?Colors.white54:yellow(),
                    helperText: ''),
                const SizedBox(height: 10.0,),
                Text('Описание продукта', style: textTheme.textTheme.bodyLarge,),
                CustomTextField(
                    hintText: '',
                    textInputType: TextInputType.text,
                    controller: productDescriptionController,
                    hintcolor: !_validate?Colors.white54:yellow(),
                    helperText: ''),
                const SizedBox(height: 10.0,),
                Text('За какое количество цена', style: textTheme.textTheme.bodyLarge,),
                CustomTextField(
                    hintText: '',
                    textInputType: TextInputType.text,
                    controller: productWeightController,
                    hintcolor: !_validate?Colors.white54:yellow(),
                    helperText: ''),
                const SizedBox(height: 10.0,),
                Text('Цена продукта', style: textTheme.textTheme.bodyLarge,),
                CustomTextField(
                    hintText: '',
                    textInputType: TextInputType.number,
                    controller: productPriceController,
                    hintcolor: !_validate?Colors.white54:yellow(),
                    helperText: ''),
                const SizedBox(height: 20.0,),
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
      );
  }
}

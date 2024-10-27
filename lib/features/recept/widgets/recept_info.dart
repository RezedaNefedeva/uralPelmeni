
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uralpelmen/features/home/widgets/button.dart';
import 'package:uralpelmen/features/profile/widgets/shared_data.dart';
import 'package:uralpelmen/models/cart_order_model/cart_order_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:uralpelmen/theme/theme.dart';
import '../../first_page/first_page.dart';
import '../../profile/widgets/widgets.dart';
import 'widgets.dart';

class ReceptInfo extends StatefulWidget {
  ReceptInfo({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.author,
  });
  final String imageUrl;
  late String title;
  final String description;
  final String ingredients;
  final String author;

  @override
  State<ReceptInfo> createState() => _ReceptInfoState();
}

class _ReceptInfoState extends State<ReceptInfo> {

  @override
  void initState() {
    SharedData.initName();
    super.initState();
  }

  late int counter = 1;

  bool isFound = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> loadImage(String imageUrl) async {
    try {
      // load network image example
      await precacheImage(NetworkImage(imageUrl), context);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    loadImage(widget.imageUrl);

    titleController.text = widget.title;
    ingredientController.text = widget.ingredients;
    descriptionController.text = widget.description;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 120,),
                SharedData.userName == widget.author ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                        IconButton(
                           onPressed: (){
                             showDialog(
                                 context: context,
                                 builder: (context) {
                                   return AlertDialog(
                                    title: const Text('Редактировать рецепт'),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text('Ингредиенты', style: textTheme.textTheme.displayMedium,),
                                            TextFieldRecept(
                                              hintText: 'Введите название и количество ингредиентов',
                                              controller: ingredientController,
                                              hintcolor: Colors.black,
                                            ),
                                            const SizedBox(height: 20.0,),
                                            Text('Описание рецепта', style: textTheme.textTheme.displayMedium,),
                                            TextFieldRecept(
                                              hintText: 'Напишите свой рецепт',
                                              controller: descriptionController,
                                              hintcolor: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                     actions: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [
                                           button(
                                               text: 'Отмена',
                                               onTap: (){
                                                 Navigator.pop(context);
                                               },
                                               width: 110,
                                               height: 40,
                                               img: 'assets/btn_des.png'),
                                           button(
                                               text: 'Сохранить',
                                               onTap: (){
                                                 FirebaseFirestore.instance.collection('recepts').doc(widget.title).update({

                                                   'receptIngredient' : ingredientController.text,
                                                   'receptDescription' : descriptionController.text,
                                                 }
                                                 );
                                                 Navigator.pop(context);
                                               },
                                               width: 110,
                                               height: 40,
                                               img: 'assets/btn_des.png'),
                                         ],
                                       )
                                     ],
                                   );
                                 });
                          },
                          icon: const Icon(Icons.edit)),
                        Text('Редактировать рецепт', style: textTheme.textTheme.bodyLarge,)
                    ]) :
                Text('', style: textTheme.textTheme.labelSmall,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child:
                    CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: yellow(),
                              strokeWidth: 2,),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(widget.title, style:  textTheme.textTheme.labelLarge, textAlign: TextAlign.center,),
                const SizedBox(height: 40,),
                Text('Ингредиенты:', style: textTheme.textTheme.bodySmall,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: Text(widget.ingredients, style: textTheme.textTheme.bodyLarge,))
                  ],
                ),
                const SizedBox(height: 40,),
                Text('Описание рецепта:', style: textTheme.textTheme.bodySmall,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: Text(widget.description, style: textTheme.textTheme.bodyLarge,))
                  ],
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Автор рецепта:', style: textTheme.textTheme.bodySmall,),
                    Text(widget.author, style: textTheme.textTheme.bodySmall,),
                  ],
                ),
                const SizedBox(height: 40,),
                SharedData.userPhone == '89279589087' || SharedData.userPhone == '89823319788'?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const SizedBox(width: 20,),
                      IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Рецепт будет удален безвозвратно.\nУдалить?'),
                                    actions: [
                                      button(
                                          text: 'Отмена',
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          width: 100,
                                          height: 40,
                                          img: 'assets/btn_des.png'),
                                      button(
                                          text: 'Удалить',
                                          onTap: (){
                                            FirebaseFirestore.instance.collection('recepts').doc(widget.title).delete();
                                            Navigator.pop(context);
                                            streamController.add(3);
                                          },
                                          width: 100,
                                          height: 40,
                                          img: 'assets/btn_des.png'),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete_outline)),
                      Text('Удалить рецепт', style: textTheme.textTheme.bodyLarge,)
                    ]) :
                Text('', style: textTheme.textTheme.labelSmall,),
              ],
            ),
          ]
      ),
    );
  }
}

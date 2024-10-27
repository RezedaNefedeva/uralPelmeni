
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class getImage extends StatefulWidget {
  const getImage({super.key});

  static XFile? image;

  @override
  State<getImage> createState() => _getImageState();
}

class _getImageState extends State<getImage> {

  //this is the state variable

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final img =
                await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  getImage.image = img;
                });
              },
              child: (getImage.image != null)? SizedBox(
                width: 160,
                height: 160,
                child: Column(
                  children: [
                    //This will show image on to the screen
                    Expanded(child: Image.file(File(getImage.image!.path))),
                  ],
                ),
              ) :
              const SizedBox(
                width: 160,
                height: 160,
                child: Image(image: AssetImage('assets/choose_img.png')),),
            ),
          ],
        ),
        //check the image state and
        //update the UI

      ],
    );
  }
}
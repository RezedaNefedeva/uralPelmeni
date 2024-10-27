
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uralpelmen/features/recept/recept.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';
import 'package:uralpelmen/theme/theme.dart';
import '../../first_page/first_page.dart';
import '../../first_page/widgets/widgets.dart';

class ReceptCard extends StatefulWidget {
  ReceptCard({super.key,
  required this.receptImage,
  required this.receptTitle,
  required this.receptIngredient,
  required this.author,
  });
  final String receptImage;
  final String receptTitle;
  final String receptIngredient;
  final String author;

  @override
  State<ReceptCard> createState() => _ReceptCardState();
}

class _ReceptCardState extends State<ReceptCard> {
  late int counter;

  bool isFound = false;

  late ReceptModel receptModel;

  Future<void> loadImage(String imageUrl) async {
    try {
      // load network image example
      await precacheImage(NetworkImage(imageUrl), context);
      // or
      // Load assets image example
      // await precacheImage(AssetImage(imagePath), context);
      print('Image loaded and cached successfully!');
    } catch (e) {
      print('Failed to load and cache the image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);

    loadImage(widget.receptImage);

    return InkWell(
      onTap: () {
        setState(() {
          ReceptPage.recept_title = widget.receptTitle;
          streamController.add(16);
          streamControllerBottom.add(3);
          ReceptPage.backFrom = false;
        });
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: yellow(),
        elevation: 5,
        child: SizedBox(
          height: 140,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: SizedBox(
                  width: 124,
                  height: 124,
                  child:
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.receptImage,
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
              const Padding(padding: EdgeInsets.only(right: 8)),
              // Row(
              //     children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          child: Text(widget.receptTitle,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: textTheme.textTheme.displayMedium,),
                        ),
                        Container(
                          width: 200,
                          child: Text(widget.receptIngredient,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.textTheme.bodyLarge,
                                maxLines: 2,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(widget.author,
                              style: textTheme.textTheme.bodyLarge,),
                          ],
                        )
                      ],

                    ),
              //     ]
              // )
            ],
          ),
        ),
      ),
    );
  }
}

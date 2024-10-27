
import 'package:flutter/material.dart';
import 'package:uralpelmen/theme/theme.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const HeaderAppBar({super.key,
    required this.title,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Container(
      height: preferredSize.height,
      color: fon(),
      child: AppBar(
        backgroundColor: fon(),
        title: Text(title, style: textTheme.textTheme.labelLarge, textAlign: TextAlign.center,),
        centerTitle: true,
      ),
    );
  }
}
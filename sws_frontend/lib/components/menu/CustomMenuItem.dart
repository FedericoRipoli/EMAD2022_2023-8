import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CustomMenuItem extends StatelessWidget{
  final String text;
  final VoidCallback  f;

  const CustomMenuItem({super.key, required this.text, required this.f});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GFTypography(
        text: text,
        textColor: Colors.black,
        dividerWidth: 120,
        dividerColor: appTheme.primaryColor,
        type: GFTypographyType.typo4,
      ),
      onTap: f
    );
  }

}
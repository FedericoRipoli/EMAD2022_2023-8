

import 'package:flutter/material.dart';

import '../main.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomFloatingButton(
      {Key? key, required this.iconData, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
        elevation: 3,
        hoverElevation: 1,
        onPressed: onPressed,
        backgroundColor: appTheme.primaryColor,
        child: Icon(
          iconData,
          size: 28,
          color: Colors.white,
        ));
  }
}

import 'package:flutter/material.dart';

import '../main.dart';
import '../theme/theme.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomFloatingButton(
      {Key? key, required this.iconData, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 8,
        hoverElevation: 4,
        onPressed: onPressed,
        backgroundColor: AppColors.logoCadmiumOrange,
        child: Icon(
          iconData,
          size: 28,
          color: Colors.white,
        ));
  }
}

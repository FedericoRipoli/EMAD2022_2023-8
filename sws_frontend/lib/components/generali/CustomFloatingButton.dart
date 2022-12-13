import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomFloatingButton(
      {Key? key, required this.iconData, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        heroTag: null,
        elevation: 4,
        hoverElevation: 2,
        onPressed: onPressed,
        backgroundColor: AppColors.logoBlue,
        child: Icon(
          iconData,
          size: 28,
          color: Colors.white,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final bool status;
  final IconData? icon;

  const Button(
      {Key? key,
      required this.onPressed,
      required this.textButton,
      required this.status,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFButton(
      elevation: 10,
      color: AppColors.logoBlue,
      padding: const EdgeInsets.only(left: 16, right: 16),
      onPressed: onPressed,
      text: textButton,
      textStyle: const TextStyle(
          color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16),
      icon: Icon(
        icon,
        color: AppColors.white,
        size: 16,
      ),
      buttonBoxShadow: true,
      shape: GFButtonShape.pills,
      size: 55.0,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final IconData? icon;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.textButton,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFButton(
      elevation: 12,

      color: AppColors.logoBlue,
      padding: const EdgeInsets.only(left: 18, right: 18),
      onPressed: onPressed,
      text: textButton,
      textStyle: const TextStyle(
          color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18),
      icon: Icon(
        icon,
        color: AppColors.white,
        size: MediaQuery.of(context).size.height * 0.02,
      ),
      buttonBoxShadow: false,
      borderSide: BorderSide.none,
      shape: GFButtonShape.pills,
      size: MediaQuery.of(context).size.height * 0.05,
    );
  }
}

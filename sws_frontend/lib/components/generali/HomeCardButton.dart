import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class HomeCardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color bgColor;
  const HomeCardButton(
      {Key? key, required this.onPressed, required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFButton(
      elevation: 0,
      color: bgColor,
      padding: const EdgeInsets.all(3),
      onPressed: onPressed,
      text: "",
      textStyle: const TextStyle(
          color: AppColors.logoBlue, fontWeight: FontWeight.bold, fontSize: 18),
      icon: Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.logoBlue,
        size: 32,
      ),
      buttonBoxShadow: false,
      borderSide: BorderSide.none,
      shape: GFButtonShape.pills,
      size: MediaQuery.of(context).size.height * 0.05,
    );
  }
}

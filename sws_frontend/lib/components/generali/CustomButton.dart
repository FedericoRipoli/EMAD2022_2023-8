import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String textButton;
  final IconData? icon;
  final Color? bgColor;
  final bool? fullWidth;

  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.textButton,
      this.icon,
      this.bgColor,
      this.fullWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFButton(
      elevation: 12,
      fullWidthButton: fullWidth ?? false,
      disabledColor: Colors.blueGrey,
      color: bgColor ?? AppColors.logoBlue,
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

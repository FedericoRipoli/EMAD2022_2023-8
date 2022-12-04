import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class CustomAvatar extends StatelessWidget {
  final double size;
  const CustomAvatar({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFAvatar(
        shape: GFAvatarShape.circle,
        backgroundColor: AppColors.white,
        child: Image.asset(
          "assets/images/user_default.png",
          width: size,
        ));
  }
}
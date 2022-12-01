import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFAvatar(
        shape: GFAvatarShape.circle,
        backgroundColor: AppColors.white,
        child: Image.asset(
          "assets/images/user_default.png",
          width: 55,
        ));
  }
}

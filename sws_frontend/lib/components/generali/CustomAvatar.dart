import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class CustomAvatar extends StatelessWidget {
  final double size;
  final IconData icon;
  const CustomAvatar({Key? key, required this.size, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFAvatar(
        shape: GFAvatarShape.circle,
        backgroundColor: AppColors.white,
        child: Icon(icon, size: size, color: AppColors.logoCadmiumOrange));
  }
}

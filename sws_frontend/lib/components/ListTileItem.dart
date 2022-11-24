import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/getwidget.dart';

class ListTileItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;
  final IconData? icon;
  const ListTileItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.description,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      color: AppColors.white,
      margin: const EdgeInsets.all(2),
      avatar: const GFAvatar(
        shape: GFAvatarShape.standard,
        backgroundColor: AppColors.logoBlue,
        child: Icon(Icons.account_circle),
      ),
      titleText: title,
      subTitleText: subtitle,
      description: Text(description!),
      icon: Icon(icon!),
    );
  }
}

import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/theme.dart';

class AreaListItem extends StatelessWidget {
  final String name, id;
  final VoidCallback onTap, onDelete;
  const AreaListItem(
      {super.key,
      required this.name,
      required this.id,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.all(8),
      avatar: GFAvatar(
        shape: GFAvatarShape.circle,
        backgroundColor: AppColors.logoBlue,
        child: Text(
          name.substring(0, 2).toUpperCase(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      color: AppColors.ice,
      onTap: onTap,
      titleText: name,
      icon: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete),
        color: AppColors.logoRed,
      ),
    );
  }
}

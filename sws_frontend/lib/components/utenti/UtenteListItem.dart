import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/theme.dart';

class UtenteListItem extends StatelessWidget {
  final String name, id;
  final String? ente;
  final VoidCallback onTap, onDelete;
  const UtenteListItem(
      {super.key,
      required this.name,
      required this.ente,
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
            name.length>2? name.substring(0, 2).toUpperCase():name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      color: AppColors.ice,
      onTap: onTap,
      titleText: name,
      subTitleText: ente ?? "",
      icon: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete),
        color: AppColors.logoRed,
      ),
    );
  }
}

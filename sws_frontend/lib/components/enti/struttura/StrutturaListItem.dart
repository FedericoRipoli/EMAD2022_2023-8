import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';


class StrutturaListItem extends StatelessWidget{
  final String denominazione, id;
  final VoidCallback onTap, onDelete;
  const StrutturaListItem({super.key, required this.denominazione, required this.id, required this.onTap, required this.onDelete});


  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.all(4),
      avatar: const GFAvatar(
        shape: GFAvatarShape.standard,
      ),
      onTap: onTap,
      titleText: denominazione,
      icon: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete),
        color: AppColors.logoRed,

      ),
    );
  }

}
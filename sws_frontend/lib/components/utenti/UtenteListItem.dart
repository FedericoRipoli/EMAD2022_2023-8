import 'package:frontend_sws/components/CustomAvatar.dart';
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
    return GFCard(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      title: GFListTile(
        padding: const EdgeInsets.all(8),
        avatar: const CustomAvatar(
          size: 35,
        ),
        color: AppColors.white,
        onTap: onTap,
        titleText: name,
        subTitleText: ente ?? "",
        icon: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_rounded),
          color: AppColors.logoCadmiumOrange,
        ),
      ),
    );
  }
}

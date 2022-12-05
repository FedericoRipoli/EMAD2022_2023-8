import 'package:frontend_sws/components/generali/CustomAvatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../services/entity/Servizio.dart';
import '../../theme/theme.dart';

class ServizioListItem extends StatelessWidget {
  final String name, id;
  final VoidCallback onTap, onDelete;
  final String statoOperazione;
  const ServizioListItem(
      {super.key,
      required this.name,
      required this.id,
      required this.onTap,
      required this.onDelete,
      required this.statoOperazione
      });

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
          imgAsset: "assets/images/user_default.png",
          size: 35,
        ),
        color: AppColors.white,
        onTap: onTap,
        titleText: name,
        icon: Servizio.canEnteEdit(statoOperazione)? IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_rounded),
          color: AppColors.logoCadmiumOrange,
        ):null,
      ),
    );
  }
}

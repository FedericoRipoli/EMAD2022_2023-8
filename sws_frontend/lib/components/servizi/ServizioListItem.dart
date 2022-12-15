import 'package:frontend_sws/components/generali/CustomAvatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../services/entity/Servizio.dart';
import '../../theme/theme.dart';
import '../generali/ConfirmBox.dart';

class ServizioListItem extends StatelessWidget {
  final String name, id;
  final VoidCallback onTap;
  final VoidCallback ? onDelete;
  final String statoOperazione;
  const ServizioListItem(
      {super.key,
      required this.name,
      required this.id,
      required this.onTap,
      this.onDelete,
      required this.statoOperazione});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.ice,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
      child: GFListTile(
        padding: const EdgeInsets.all(8),
        avatar: const CustomAvatar(
          icon: Icons.handshake_rounded,
          size: 35,
        ),
        onTap: onTap,
        titleText: name,
        icon:onDelete!=null && Servizio.canEnteEdit(statoOperazione)
            ? IconButton(
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmBox(
                        label: name,
                        onDelete: onDelete!,
                      );
                    },
                  ),
                },
                icon: const Icon(Icons.delete_rounded),
                color: AppColors.logoCadmiumOrange,
              )
            : null,
      ),
    );
  }
}

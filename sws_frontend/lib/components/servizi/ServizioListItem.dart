import 'package:frontend_sws/components/generali/CustomAvatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../services/entity/Servizio.dart';
import '../../theme/theme.dart';
import '../generali/ConfirmBox.dart';

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
      required this.statoOperazione});

  @override
  Widget build(BuildContext context) {
    return GFCard(
      elevation: 8,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(28.0),
      title: GFListTile(
        padding: const EdgeInsets.all(8),
        avatar: const CustomAvatar(
          icon: Icons.handshake_rounded,
          size: 35,
        ),
        onTap: onTap,
        titleText: name,
        icon: Servizio.canEnteEdit(statoOperazione)
            ? IconButton(
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmBox(
                        label: name,
                        onDelete: onDelete,
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

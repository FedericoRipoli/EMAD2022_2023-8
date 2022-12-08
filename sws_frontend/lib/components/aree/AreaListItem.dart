import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/theme.dart';
import '../generali/ConfirmBox.dart';
import '../generali/CustomAvatar.dart';

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
    return GFCard(
      elevation: 8,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(28.0),

      title: GFListTile(
        padding: const EdgeInsets.all(8),
        avatar: const CustomAvatar(
          imgAsset: "assets/images/area.png",
          size: 35,
        ),
        onTap: onTap,
        titleText: name,
        icon: IconButton(
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
        ),
      ),
    );
  }
}

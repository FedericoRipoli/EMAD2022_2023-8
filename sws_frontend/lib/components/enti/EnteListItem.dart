import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../generali/ConfirmBox.dart';
import '../generali/CustomAvatar.dart';

class EnteListItem extends StatelessWidget {
  final String denominazione, id;
  final VoidCallback onTap, onDelete;
  const EnteListItem(
      {super.key,
      required this.denominazione,
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
        avatar: const CustomAvatar(
          imgAsset: "assets/images/listtile_ente.png",
          size: 35,
        ),
        onTap: onTap,
        titleText: denominazione,
        icon: IconButton(
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmBox(
                  label: denominazione,
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

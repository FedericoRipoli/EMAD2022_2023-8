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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppColors.detailBlue,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
      child: GFListTile(
        avatar: const CustomAvatar(
          icon: Icons.people_rounded,
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
          color: AppColors.logoRed,
        ),
      ),
    );
  }
}

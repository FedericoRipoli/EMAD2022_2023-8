import 'package:frontend_sws/components/generali/CustomAvatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../generali/ConfirmBox.dart';

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
    return Card(
      elevation: 4,
      color: AppColors.ice,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
      child: GFListTile(
        avatar: const CustomAvatar(
          icon: Icons.face,
          size: 35,
        ),
        //color: AppColors.white,
        onTap: onTap,
        titleText: name,
        subTitleText: ente ?? "",
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

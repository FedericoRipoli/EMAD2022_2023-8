import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../generali/ConfirmBox.dart';
import '../../generali/CustomAvatar.dart';

class StrutturaListItem extends StatelessWidget {
  final String denominazione, id, indirizzo;
  final VoidCallback? onTap;
  final VoidCallback?  onDelete;
  const StrutturaListItem(
      {super.key,
      required this.denominazione,
        required this.indirizzo,
      required this.id,
      this.onTap,
      this.onDelete});

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
        padding: const EdgeInsets.all(4),
        avatar: const CustomAvatar(
          icon: Icons.maps_home_work_rounded,
          size: 35,
        ),
        onTap: onTap,
        titleText: denominazione,
        subTitleText: indirizzo,
        icon:onDelete==null?null: IconButton(
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmBox(
                  label: denominazione,
                  onDelete: onDelete!,
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

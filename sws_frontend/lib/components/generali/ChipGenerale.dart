import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';

class ChipGenerale extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;

  const ChipGenerale({Key? key, required this.label, required this.icon, this.iconColor,this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.all(10),
      label: Text(label),
      elevation: 3,
      avatar: Icon(
        icon,
        color: iconColor ?? AppColors.logoBlue,
      ),
      backgroundColor: backgroundColor ?? AppColors.white,
    );
  }
}

enum Stato { DA_APPROVARE, APPROVATO, IN_MODIFICA, ANNULLATO }

class ChipState extends StatelessWidget {
  final Stato state;
  const ChipState({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background = AppColors.logoRed;
    IconData icon = Icons.not_interested;
    String label = "Annullato";

    switch (state) {
      case Stato.DA_APPROVARE:
        {
          background = AppColors.logoCadmiumOrange;
          icon = Icons.remove_done;
          label = "Da approvare";
        }
        break;
      case Stato.APPROVATO:
        {
          background = Colors.green;
          icon = Icons.done;
          label = "Approvato";
        }
        break;
      case Stato.IN_MODIFICA:
        {
          background = AppColors.logoCadmiumOrange;
          icon = Icons.mode;
          label = "In modifica";
        }
        break;
      default:
        {}
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: AppColors.white),
      ),
      elevation: 10,
      avatar: Icon(
        icon,
        color: AppColors.white,
      ),
      backgroundColor: background,
    );
  }
}

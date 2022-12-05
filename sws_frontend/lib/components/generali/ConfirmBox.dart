import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/getwidget.dart';

class ConfirmBox extends StatefulWidget {
  final String label;
  final VoidCallback onDelete;
  const ConfirmBox({Key? key, required this.label, required this.onDelete})
      : super(key: key);

  @override
  State<ConfirmBox> createState() => _ConfirmBoxState();
}

class _ConfirmBoxState extends State<ConfirmBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(34.0))),
      title: const Text(
        "Attenzione",
        style: TextStyle(
            color: AppColors.logoCadmiumOrange, fontWeight: FontWeight.bold),
      ),
      content: Text("Stai per eliminare ${widget.label}, vuoi procedere?"),
      actions: [
        GFButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColors.logoRed,
          text: "Annulla",
          icon: const Icon(
            Icons.cancel,
            color: AppColors.logoRed,
          ),
          type: GFButtonType.outline,
          shape: GFButtonShape.pills,
        ),
        GFButton(
          onPressed: widget.onDelete,
          color: Colors.green,
          text: "Conferma",
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          type: GFButtonType.outline,
          shape: GFButtonShape.pills,
        ),
      ],
    );
  }
}

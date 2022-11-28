import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class UtenteListItem extends StatelessWidget{
  final String name, id;
  final String? ente;
  final VoidCallback  onTap, onDelete;
  const UtenteListItem({super.key, required this.name, required this.ente, required this.id, required this.onTap, required this.onDelete});


  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.all(4),
      avatar: const GFAvatar(
        shape: GFAvatarShape.standard,
      ),
      onTap: onTap,
      titleText: name,
      subTitleText: ente??"",
      icon: IconButton(
        onPressed: onDelete,
        icon: Icon(Icons.delete),
        color: Colors.red,
      ),
    );
  }

}
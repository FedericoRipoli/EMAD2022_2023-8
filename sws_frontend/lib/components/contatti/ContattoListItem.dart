import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class ContattoListItem extends StatelessWidget{
  final String denominazione, id;
  final VoidCallback  onTap;
  const ContattoListItem({super.key, required this.denominazione, required this.id, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.all(4),
      avatar: const GFAvatar(
        shape: GFAvatarShape.standard,
      ),
      onTap: onTap,
      titleText: denominazione,
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }

}
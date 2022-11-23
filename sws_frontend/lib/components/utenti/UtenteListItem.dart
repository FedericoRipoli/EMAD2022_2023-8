import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class UtenteListItem extends StatelessWidget{
  final String name, id;
  final String? ente;

  const UtenteListItem({super.key, required this.name, required this.ente, required this.id});


  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.all(4),
      avatar: const GFAvatar(
        shape: GFAvatarShape.standard,
      ),
      titleText: name,
      subTitleText: ente??"",
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }

}
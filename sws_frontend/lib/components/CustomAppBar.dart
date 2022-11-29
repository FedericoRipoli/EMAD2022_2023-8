import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

import '../main.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData iconData;
  const CustomAppBar({Key? key,
    required this.onPressed,
    required this.title,
    required this.iconData}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return GFAppBar(
      title: Text(widget.title),
      leading: GFIconButton(
        icon: Icon(
          widget.iconData,
          color: Colors.white,
        ),
        onPressed: widget.onPressed,
        type: GFButtonType.transparent,
      ),
      searchBar: false,
      elevation: 0,
      backgroundColor: appTheme.primaryColor,
    );
  }
}



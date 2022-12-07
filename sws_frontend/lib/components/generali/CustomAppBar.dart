import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

import '../../main.dart';
import '../../theme/theme.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  final Widget title;
  final IconData? iconData;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar(
      {Key? key,
      this.onPressed,
      required this.title,
      this.iconData,
      this.actions=const [],
      this.bottom})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: widget.title,
        leading: widget.onPressed != null && widget.iconData != null
            ? GFIconButton(
                icon: Icon(
                  widget.iconData,
                  color: Colors.white,
                ),
                onPressed: widget.onPressed,
                type: GFButtonType.transparent,
              )
            : null,
        //searchBar: false,
        elevation: 1,
        backgroundColor: appTheme.primaryColor,
        actions: widget.actions,
        bottom: widget.bottom,
    );
  }
}

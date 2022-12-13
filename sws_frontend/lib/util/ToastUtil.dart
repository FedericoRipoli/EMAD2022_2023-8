import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ToastUtil {
  static void show(
      String text, BuildContext context, IconData iconData, Color iconColor) {
    GFToast.showToast(
      text,
      context,
      toastPosition: GFToastPosition.BOTTOM,
      textStyle: const TextStyle(fontSize: 18, color: GFColors.DARK),
      backgroundColor: Colors.white,
      trailing: Icon(iconData, color: iconColor),
    );
  }

  static void success(String text, BuildContext context) {
    show(text, context, Icons.verified_outlined, GFColors.SUCCESS);
  }

  static void error(String text, BuildContext context) {
    show(text, context, Icons.error_outline, GFColors.DANGER);
  }
}

import 'package:flutter/material.dart';
import 'package:frontend_sws/components/Button.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ToastUtil {
  static void show(
      String text, BuildContext context, IconData iconData, Color iconColor) {
    GFToast.showToast(
      text,
      context,
      toastPosition: GFToastPosition.BOTTOM,
      textStyle: const TextStyle(fontSize: 18, color: GFColors.DARK),
      backgroundColor: Colors.grey.withOpacity(0.7),
      trailing: Icon(iconData, color: iconColor),
    );
  }

  static void success(String text, BuildContext context){
    show(text,context,Icons.verified_outlined,GFColors.SUCCESS);
  }
  static void error(String text, BuildContext context){
    show(text,context,Icons.error_outline,GFColors.DANGER);
  }
}

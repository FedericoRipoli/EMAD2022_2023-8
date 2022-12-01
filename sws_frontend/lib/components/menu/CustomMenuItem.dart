import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CustomMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback f;

  const CustomMenuItem({super.key, required this.text, required this.f});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        color: AppColors.white,
        child: ListTile(
            title: Text(
              text,
              style: TextStyle(color: AppColors.black, fontSize: 16),
            ),
            onTap: f,
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.logoCadmiumOrange,
            )));
  }
}

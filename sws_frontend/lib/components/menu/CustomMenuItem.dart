import 'package:frontend_sws/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback f;

  const CustomMenuItem({super.key, required this.text, required this.f});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppColors.detailBlue,
        child: ListTile(
            title: Text(
              text,
              style: const TextStyle(color: AppColors.black, fontSize: 16),
            ),
            onTap: f,
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.logoCadmiumOrange,
            )));
  }
}

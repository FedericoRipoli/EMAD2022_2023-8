import 'package:frontend_sws/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback f;

  const CustomMenuItem({super.key, required this.text, required this.f});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: Colors.white,
        child: ListTile(
            title: Text(
              text,
              style: const TextStyle(color: AppColors.black, fontSize: 16),
            ),
            onTap: f,
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.logoBlue,
            )));
  }
}

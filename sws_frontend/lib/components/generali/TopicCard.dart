import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';

class TopicCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const TopicCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
      color: AppColors.ice,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            minVerticalPadding: 12,
            onTap: onTap,
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: const Text("Scopri di più",
                style: TextStyle(
                    color: AppColors.logoBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16)),
            trailing: Icon(
              icon,
              color: AppColors.logoCadmiumOrange,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}

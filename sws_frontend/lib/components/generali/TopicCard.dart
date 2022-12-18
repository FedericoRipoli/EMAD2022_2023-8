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
      elevation: 6,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 0),
      color: AppColors.detailBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.logoCadmiumOrange,
                size: 36,
              ),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              const Text(
                "Scopri di più",
                style: TextStyle(
                    color: AppColors.logoBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}

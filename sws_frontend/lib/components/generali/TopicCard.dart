import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';

import 'HomeCardButton.dart';

class TopicCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final String image;
  final VoidCallback onTap;
  final String? buttonLabel;
  final Color bgColor, btnColor;
  const TopicCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.image,
      required this.onTap,
      this.buttonLabel,
      required this.bgColor,
      required this.btnColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 1.7,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.logoCadmiumOrange,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: AppColors.white,
                    size: 36,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: HomeCardButton(
                  //onPressed: onTap,
                  bgColor: btnColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

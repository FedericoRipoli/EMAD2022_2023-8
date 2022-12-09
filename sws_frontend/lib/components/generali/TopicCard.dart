import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';

class TopicCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String image;
  final VoidCallback onTap;
  final String? buttonLabel;
  final Color bgColor, btnColor;
  const TopicCard(
      {super.key,
      required this.title,
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
        height: 110,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 0.9,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      const Text(
                        "Scopri di più",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.logoBlue,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(3),
                child: Icon(
                  icon,
                  size: 38,
                  color: AppColors.logoCadmiumOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*child: Container(
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
              ),*/

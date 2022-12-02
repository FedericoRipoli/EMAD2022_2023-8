import 'package:flutter/material.dart';
import 'package:frontend_sws/components/CustomButton.dart';
import 'package:frontend_sws/theme/theme.dart';

class TopicCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final String image;
  final VoidCallback onTap;
  final String? buttonLabel;
  final Color? bgColor;
  const TopicCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.image,
      required this.onTap,
      this.buttonLabel,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: 200, maxWidth: 800, minHeight:250, maxHeight: 400),
        margin: const EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.06,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.logoCadmiumOrange,
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: AppColors.white,
                          size: MediaQuery.of(context).size.height * 0.045,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CustomButton(
                      onPressed: onTap,
                      textButton: buttonLabel ?? "Esplora",
                      status: true,
                      icon: Icons.arrow_forward_ios_rounded,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

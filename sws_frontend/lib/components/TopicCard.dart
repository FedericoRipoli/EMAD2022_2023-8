import 'package:flutter/material.dart';
import 'package:frontend_sws/components/CustomButton.dart';
import 'package:frontend_sws/theme/theme.dart';

class TopicCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final String image;
  final VoidCallback onTap;
  final String? buttonLabel;
  const TopicCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.image,
      required this.onTap,
      this.buttonLabel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 266.0,
        width: 366.0,
        decoration: BoxDecoration(
            color: AppColors.white,
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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      image,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.logoCadmiumOrange,
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: AppColors.white,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
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

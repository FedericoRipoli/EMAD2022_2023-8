import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_sws/theme/theme.dart';

class TopicCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool disabled;
  final bool? isOlivia;
  const TopicCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.disabled = false,
    this.isOlivia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        foregroundDecoration: !disabled
            ? null
            : const BoxDecoration(
                color: AppColors.white,
                backgroundBlendMode: BlendMode.saturation,
              ),
        child: GestureDetector(
            onTap: disabled ? null : onTap,
            child: Card(
                elevation: 6,
                margin: const EdgeInsets.only(
                    left: 12, right: 12, bottom: 12, top: 5),
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isOlivia != null
                          ? SvgPicture.asset(
                              "svg/chatbot.svg",
                              color: AppColors.logoCadmiumOrange,
                              width: 46,
                            )
                          : Icon(
                              icon,
                              color: AppColors.logoCadmiumOrange,
                              size: 36,
                            ),
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      const Text(
                        "Scopri di più",
                        style: TextStyle(
                            color: AppColors.logoBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      )
                    ],
                  ),
                ))));
  }
}

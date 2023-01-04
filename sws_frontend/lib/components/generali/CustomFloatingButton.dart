import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/theme.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final bool? isOlivia;

  const CustomFloatingButton(
      {Key? key,
      required this.iconData,
      required this.onPressed,
      this.isOlivia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        heroTag: null,
        elevation: 4,
        hoverElevation: 2,
        onPressed: onPressed,
        backgroundColor: AppColors.logoBlue,
        child: isOlivia != null
            ? SvgPicture.asset(
                kIsWeb ? "svg/chatbot.svg" : "assets/svg/chatbot.svg",
                color: AppColors.white,
                width: 36,
              )
            : Icon(
                iconData,
                size: 28,
                color: Colors.white,
              ));
  }
}

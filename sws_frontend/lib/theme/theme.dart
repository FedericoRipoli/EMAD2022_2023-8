import 'package:flutter/material.dart';

class AppColors {
  // interface colors
  static const Color primaryBlue = Color(0xFF5751FF);
  static const Color grayPurple = Color(0xFF6D72A6);
  static const Color darkBlue = Color(0xFF2F4F75);
  static const Color ice = Color(0xFFEEF7FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color greyLight = Color(0xFFDBDBDB);
  static const Color detailBlue = Color(0xFFEEF4F4);
  // logo colors
  static const Color logoBlue = Color(0XFF0973BA); //
  static const Color logoYellow = Color(0XFFFCDE05);
  static const Color logoCyan = Color(0XFF4EB8E6);
  static const Color logoRed = Color(0XFFF1615F);
  static const Color logoCadmiumOrange = Color(0XFFfd7e1c); //F7954A
  // util colors
  static const Color bgWhite = Color(0XFFFCFEFC);
  static const Color newBlue = Color(0XFF4B37C3);
  static const Color bgLightBlue = Color(0XFFE4E6FF);
}

class AppTitle extends StatelessWidget {
  final String label;
  final Color? color;
  const AppTitle({Key? key, required this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
          fontFamily: "Lexend",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: color ?? AppColors.white,
        ));
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontFamily: "Lexend",
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Salerno '),
          TextSpan(
            text: 'Amica',
          ),
        ],
      ),
    );
  }
}

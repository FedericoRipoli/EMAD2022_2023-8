import 'package:flutter/material.dart';

class AppColors {
  // interface colors
  static const Color primaryBlue = Color(0xFF5751FF);
  static const Color grayPurple = Color(0xFF6D72A6);
  static const Color darkBlue = Color(0xFF2F4F75);
  static const Color ice = Color(0xFFEFEFEF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color greyLight = Color(0xFFFFFFFE);
  static const Color detailBlue = Color(0xFFE6F4F1);
  // logo colors
  static const Color logoBlue = Color(0XFF0973BA);
  static const Color logoYellow = Color(0XFFFCDE05);
  static const Color logoCyan = Color(0XFF4EB8E6);
  static const Color logoRed = Color(0XFFF1615F);
  static const Color logoCadmiumOrange = Color(0XFFF7954A);
}

class AppTitle extends StatelessWidget {
  final String label;
  final Color? color;
  const AppTitle({Key? key, required this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
          fontFamily: "FredokaOne",
          fontSize: 20,
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
          fontFamily: "FredokaOne",
          letterSpacing: 1,
          fontSize: 32.0,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Salerno\n'),
          TextSpan(
              text: 'Amica',
              style: TextStyle(
                color: AppColors.logoCadmiumOrange,
              )),
        ],
      ),
    );
  }
}

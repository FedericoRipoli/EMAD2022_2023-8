import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/components/Splash.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MaterialApp(
    builder: (context, child) => ResponsiveWrapper.builder(
      child,
      maxWidth: 1280,
      minWidth: 390,
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(390, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(1024, name: TABLET),
        const ResponsiveBreakpoint.resize(1280, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
      ],
    ),
    debugShowCheckedModeBanner: false,
    home: Splash(),
    theme: appTheme,
    title: "Salerno Amica",
  ));
}

ThemeData appTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'OpenSans',
  primaryColor: AppColors.logoBlue,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
    ),
  ),
);
// E0E3EC

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/components/Splash.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MaterialApp(
    /*builder: (context, child) => ResponsiveWrapper.builder(
      child,
      maxWidth: 1200,
      minWidth: 450,
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(450, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      ],
    ),*/
    debugShowCheckedModeBanner: false,
    home: Splash(),
    theme: appTheme,
    title: "Salerno Amica",
  ));
}

ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF0059B3),
  secondaryHeaderColor: const Color(0xFF28759E),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  splashColor: Colors.white,

  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
    ),
  ),
);
// E0E3EC

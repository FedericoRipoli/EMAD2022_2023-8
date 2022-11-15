import 'package:flutter/material.dart';
import 'screens/Introduction.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MaterialApp(
    builder: (context, child) => ResponsiveWrapper.builder(
      child,
      maxWidth: 1200,
      minWidth: 480,
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(480, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
      ],
    ),
    debugShowCheckedModeBanner: false,
    home: const Introduction(),
    theme: appTheme,
    title: "Salerno Amica",
  ));
}

ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF0059B3),
  /* Colors.tealAccent,*/
  secondaryHeaderColor: const Color(0xFF28759E) /* Colors.teal*/
  ,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
// E0E3EC

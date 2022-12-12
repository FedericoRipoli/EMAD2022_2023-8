import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/components/generali/Splash.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            maxWidth: 2100,
            minWidth: 350,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(350, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(600, name: TABLET),
              const ResponsiveBreakpoint.resize(800, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
            ],
          ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      theme: appTheme,
      title: "Salerno Amica"));
}

ThemeData appTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'OpenSans',
  primaryColor: AppColors.logoBlue,
  //useMaterial3: true,
  //colorSchemeSeed: Colors.indigo,
  primarySwatch: Colors.indigo,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
    ),
  ),
);
// E0E3EC

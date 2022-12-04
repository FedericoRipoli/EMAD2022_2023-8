import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/components/generali/Splash.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    builder: (context, widget) => ResponsiveWrapper.builder(
      ClampingScrollWrapper(
        child: widget!,
      ),
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
    title: "Salerno Amica",
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('it', 'IT'), // Spanish, no country code
    ],
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

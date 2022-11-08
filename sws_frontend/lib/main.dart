import 'package:flutter/material.dart';
import 'screens/Introduction.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Introduction(),
    theme: appTheme,
    title: "Servizi Salerno",
  ));
}

ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF0059B3),
  /* Colors.tealAccent,*/
  secondaryHeaderColor: const Color(0xFF28759E) /* Colors.teal*/
  ,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // fontFamily:
);

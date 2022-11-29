import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/screens/DraggableHomeScreen.dart';
import 'package:frontend_sws/screens/Introduction.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';

import 'AllPageLoad.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    await SharedPreferencesUtils.init();
    bool seen = (SharedPreferencesUtils.prefs
            .getBool(SharedPreferencesUtils.splashViewed) ??
        false);
    SharedPreferencesUtils.prefs.remove(SharedPreferencesUtils.chatLog);

    if (seen) {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const DraggableHomeScreen())));
    } else {
      await SharedPreferencesUtils.prefs
          .setBool(SharedPreferencesUtils.splashViewed, true);
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Introduction()));
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: AllPageLoad(),
    );
  }
}

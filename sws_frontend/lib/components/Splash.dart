import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:frontend_sws/screens/Introduction.dart';
import 'package:frontend_sws/screens/InitApp.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';

class Splash extends StatefulWidget {
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
              builder: (BuildContext context) => const InitApp())));
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
        size: 80,
        color: appTheme.primaryColor,
      )),
    );
  }
}

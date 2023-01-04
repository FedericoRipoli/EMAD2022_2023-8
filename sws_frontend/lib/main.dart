import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend_sws/components/generali/Splash.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

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
    title: "Salerno Amica",
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('de', 'DE'),
      Locale('en', 'US'),
      Locale('it', 'IT'),
    ],
    locale: const Locale('it'),
  ));
}

ThemeData appTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'OpenSans',
  primaryColor: AppColors.logoBlue,
  //useMaterial3: true,
  //colorSchemeSeed: Colors.indigo,
  primarySwatch: blueMaterialColor,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark),
  ),
);
// E0E3EC

Map<int, Color> blueColorSwatch = {
  50: const Color.fromRGBO(9, 115, 186, .1),
  100: const Color.fromRGBO(9, 115, 186, .2),
  200: const Color.fromRGBO(9, 115, 186, .3),
  300: const Color.fromRGBO(9, 115, 186, .4),
  400: const Color.fromRGBO(9, 115, 186, .5),
  500: const Color.fromRGBO(9, 115, 186, .6),
  700: const Color.fromRGBO(9, 115, 186, .8),
  800: const Color.fromRGBO(9, 115, 186, .9),
  600: const Color.fromRGBO(9, 115, 186, .7),
  900: const Color.fromRGBO(9, 115, 186, 1),
};
MaterialColor blueMaterialColor = MaterialColor(0xFF0973BA, blueColorSwatch);

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static late SharedPreferences prefs;
  static const String splashViewed =
      'it.unisa.emad.comunesalerno.sws.components.splashViewed';

  //ChatBot
  static const String chatLog = 'it.unisa.emad.comunesalerno.sws.screen.chat';

  //userservice
  static const String userLogged =
      'it.unisa.emad.comunesalerno.sws.services.userLogged';
  static const String accessToken =
      'it.unisa.emad.comunesalerno.sws.services.accessToken';

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

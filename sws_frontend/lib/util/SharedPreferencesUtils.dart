import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesUtils{
  static late SharedPreferences prefs;
  static const String splash_viewed='it.unisa.emad.comunesalerno.sws.components.splash_viewed';

  //userservice
  static const String user_logged='it.unisa.emad.comunesalerno.sws.services.user_logged';

  static init() async{
    prefs = await SharedPreferences.getInstance();
  }


}
import 'dart:convert';

import 'package:frontend_sws/services/entity/Impostazioni.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;


import '../util/QueryStringUtil.dart';
import 'RestURL.dart';
import 'UserService.dart';

class ImpostazioniService {
  final log = Logger('ImpostazioniServiceLoger');
  UserService userService = UserService();



  Future<Impostazioni?> getImpostazioni() async {
    try {
      var response = await http.get(
          Uri.parse(RestURL.impostazioniService),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return impostazioniFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Impostazioni?> createImpostazioni(Impostazioni impostazioni) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse(RestURL.impostazioniService),
          body: impostazioniToJson(impostazioni), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return impostazioniFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Impostazioni?> editImpostazioni(Impostazioni impostazioni) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse(RestURL.impostazioniService),
          body: impostazioniToJson(impostazioni),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return impostazioniFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

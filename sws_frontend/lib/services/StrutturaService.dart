import 'dart:convert';

import 'package:frontend_sws/services/entity/Struttura.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;


import '../util/QueryStringUtil.dart';
import 'RestURL.dart';
import 'UserService.dart';

class StrutturaService {
  final log = Logger('StrutturaServiceLoger');
  UserService userService = UserService();


  Future<List<Struttura>?> struttureList(String? nome, String idEnte) async {
    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();

      if (nome != null) {
        queryStringUtil.add("name", nome);
      }
      Uri u = Uri.parse(
          "${RestURL.struttureEnteService}/$idEnte?${queryStringUtil.getQueryString()}");

      var response = await http.get(
          u,
          headers: RestURL.defaultHeader);

      if (response.statusCode == 200) {
        var l = json.decode(utf8.decode(response.bodyBytes));
        return List<Struttura>.from(l.map((model) => Struttura.fromJson(model)));

      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Struttura?> getStruttura(String id) async {
    try {
      var response = await http.get(
          Uri.parse("${RestURL.struttureService}/$id"),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return strutturaFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Struttura?> createStruttura(Struttura struttura, String idEnte) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse("${RestURL.struttureService}/$idEnte"),
          body: strutturaToJson(struttura), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return strutturaFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<bool> deleteStruttura(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.struttureService}/$id"),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }
  Future<Struttura?> editStruttura(Struttura struttura) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.struttureService}/${struttura.id}"),
          body: strutturaToJson(struttura),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return strutturaFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

}

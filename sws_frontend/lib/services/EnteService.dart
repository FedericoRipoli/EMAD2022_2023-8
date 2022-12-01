import 'dart:convert';

import 'package:frontend_sws/util/QueryStringUtil.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/dto/ListResponse.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'RestURL.dart';
import 'UserService.dart';

class EnteService {
  final log = Logger('EnteServiceLogger');
  UserService userService = UserService();

  Future<List<Ente>?> enteList(String? name, int? page) async {
    try {

      QueryStringUtil queryStringUtil=QueryStringUtil();

      if (name != null) {
        queryStringUtil.add("name",name);
      }
      if (page != null) {
        queryStringUtil.add("page",page.toString());

      } else {
        queryStringUtil.addString(RestURL.queryRemovePagination);
      }

      Uri u = Uri.parse("${RestURL.enteService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u, headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        if (page != null) {
          ListResponse<Ente> l = ListResponse<Ente>.fromJson(
              jsonDecode(response.body), Ente.fromJson);
          return l.content;
        } else {
          var l = json.decode(response.body);
          return List<Ente>.from(l.map((model) => Ente.fromJson(model)));
        }
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Ente?> getEnte(String id) async {
    try {
      var response = await http.get(
          Uri.parse("${RestURL.enteService}/$id"),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return enteFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<bool> deleteEnte(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.enteService}/$id"),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }
  Future<Ente?> createEnte(Ente ente) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse(RestURL.enteService),
          body: enteToJson(ente), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return enteFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Ente?> editEnte(Ente ente) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.enteService}/${ente.id}"),
          body: enteToJson(ente),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return enteFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

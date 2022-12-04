import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart';

import '../util/QueryStringUtil.dart';
import 'RestURL.dart';
import 'UserService.dart';
import 'dto/ListResponse.dart';
import 'dto/LoginDTO.dart';
import 'dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';
import 'package:frontend_sws/util/JwtUtil.dart';

import 'entity/Servizio.dart';


class ServizioService {

  final log = Logger('ServizioServiceLogger');
  UserService userService = UserService();

  Future<List<Servizio>?> serviziList(
      String? nome, int page) async {
    String? token = await userService.getUser();

    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();

      queryStringUtil.addString("page=$page");
      if (nome != null) {
        queryStringUtil.add("nome", nome);
      }

      Uri u = Uri.parse(
          "${RestURL.servizioService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u, headers: RestURL.authHeader(token!));
      if (response.statusCode == 200) {
        ListResponse<Servizio> l = ListResponse<Servizio>.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)), Servizio.fromJson);
        return l.content;
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Servizio?> getServizio(String id) async {
    try {
      var response = await http.get(
          Uri.parse("${RestURL.servizioService}/$id"),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<bool> deleteServizio(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.servizioService}/$id"),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }
  Future<Servizio?> editServizio(Servizio servizio) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.servizioService}/${servizio.id}"),
          body: servizioToJson(servizio),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }


  Future<Servizio?> createServizio(Servizio servizio) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse(RestURL.servizioService),
          body: servizioToJson(servizio), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

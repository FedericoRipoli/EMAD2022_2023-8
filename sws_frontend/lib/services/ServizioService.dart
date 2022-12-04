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
            jsonDecode(response.body), Servizio.fromJson);
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
        return servizioFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

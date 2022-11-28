import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend_sws/services/dto/SignupDTO.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:frontend_sws/services/dto/ListResponse.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'RestURL.dart';
import 'UserService.dart';
import 'package:frontend_sws/util/QueryStringUtil.dart';

class UtenteService {
  final log = Logger('UtenteServiceLogger');
  UserService userService = UserService();

  Future<List<Utente>?> usersList(
      String? username, String? ente, bool? admin, int page) async {
    String? token = await userService.getUser();
    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();

      queryStringUtil.addString("page=$page");
      if (username != null) {
        queryStringUtil.add("username", username);
      }
      if (admin != null) {
        queryStringUtil.add("admin", admin.toString());
      }
      if (ente != null) {
        queryStringUtil.add("ente", ente);
      }
      Uri u = Uri.parse(
          "${RestURL.utenteService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u, headers: RestURL.authHeader(token!));
      if (response.statusCode == 200) {
        ListResponse<Utente> l = ListResponse<Utente>.fromJson(
            jsonDecode(response.body), Utente.fromJson);
        return l.content;
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Utente?> getUtente(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.get(
          Uri.parse("${RestURL.utenteService.toString()}/$id"),
          headers: RestURL.authHeader(token!));
      if (response.statusCode == 200) {
        return utenteFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Utente?> createUtente(SignupDto sign) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(RestURL.register,
          body: signupDtoToJson(sign), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return utenteFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<bool> deleteUtente(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.utenteService}/$id"),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }

  Future<Utente?> editUtente(Utente utente) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.utenteService}/${utente.id}"),
          body: utenteToJson(utente),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return utenteFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

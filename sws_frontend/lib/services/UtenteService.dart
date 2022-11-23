import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend_sws/services/dto/SignupDTO.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:frontend_sws/services/dto/ListResponse.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'RestURL.dart';
import 'UserService.dart';

class UtenteService {
  final log = Logger('UtenteServiceLogger');
  UserService userService = UserService();

  Future<List<Utente>?> usersList(
      String? username, String? ente, bool? admin, int page) async {
    String? token = await userService.getUser();
    try {
      var response = await http.get(RestURL.utenteService,
          headers: RestURL.authHeader(token!));
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
          Uri.parse("${RestURL.utenteService.path}/$id"),
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
          Uri.parse("${RestURL.utenteService.path}/$id"),
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
      var response = await http.delete(
          Uri.parse("${RestURL.utenteService.path}/${utente.id}"),
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

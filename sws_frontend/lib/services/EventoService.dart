import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart';
import '../util/QueryStringUtil.dart';
import 'RestURL.dart';
import 'UserService.dart';
import 'dto/ListResponse.dart';
import 'entity/Evento.dart';

class EventoService {
  final log = Logger('EventoServiceLogger');
  UserService userService = UserService();

  Future<List<Evento>?> eventiList(String? nome, String? idArea,
      int page, bool logged) async {
    String? token;
    if (logged) {
      token = await userService.getUser();
    }
    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();

      queryStringUtil.addString("page=$page");
      if (nome != null) {
        queryStringUtil.add("name", nome);
      }
      if (idArea != null) {
        queryStringUtil.add("idArea", idArea);
      }

      Uri u = Uri.parse(
          "${RestURL.eventoService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u,
          headers: token != null
              ? RestURL.authHeader(token!)
              : RestURL.defaultHeader);
      if (response.statusCode == 200) {
        ListResponse<Evento> l = ListResponse<Evento>.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)), Evento.fromJson);
        return l.content;
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Evento?> getEvento(String id) async {
    try {
      var response = await http.get(Uri.parse("${RestURL.eventoService}/$id"),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return eventoFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<bool> deleteEvento(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.eventoService}/$id"),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }

  Future<Evento?> editEvento(Evento evento) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.eventoService}/${evento.id}"),
          body: eventoToJson(evento),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return eventoFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Evento?> createEvento(Evento evento) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse(RestURL.eventoService),
          body: eventoToJson(evento), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return eventoFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

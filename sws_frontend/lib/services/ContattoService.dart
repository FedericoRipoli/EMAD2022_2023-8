import 'dart:convert';

import 'package:frontend_sws/services/entity/Contatto.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'RestURL.dart';
import 'UserService.dart';
import 'dto/ListResponse.dart';
import 'package:frontend_sws/util/QueryStringUtil.dart';
class ContattoService {
  final log = Logger('ContattoServiceLogger');
  UserService userService = UserService();

  Future<List<Contatto>?> contattoList(String? idEnte,int? page) async {
    try {
      QueryStringUtil queryStringUtil=QueryStringUtil();
      if (idEnte != null) {
        queryStringUtil.add("idEnte", idEnte);
      }
      if (page != null) {
        queryStringUtil.add("page", page.toString());
      } else {
        queryStringUtil.addString(RestURL.queryRemovePagination);
      }
      Uri u = Uri.parse("${RestURL.contattoService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u, headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        if (page != null) {
          ListResponse<Contatto> l = ListResponse<Contatto>.fromJson(
              jsonDecode(response.body), Contatto.fromJson);
          return l.content;
        } else {
          var l = json.decode(response.body);
          return List<Contatto>.from(l.map((model) => Contatto.fromJson(model)));
        }
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Contatto?> getContatto(String id) async {
    try {
      var response = await http.get(
          Uri.parse("${RestURL.contattoService.toString()}/$id"),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return contattoFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<bool> deleteContatto(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.contattoService}/$id"),
          headers: RestURL.authHeader(token!));


      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }
  Future<Contatto?> createContatto(Contatto contatto) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse(RestURL.contattoService),
          body: contattoToJson(contatto),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return contattoFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Contatto?> editContato(Contatto contatto) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.contattoService}/${contatto.id}"),
          body: contattoToJson(contatto),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return contattoFromJson(response.body);
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

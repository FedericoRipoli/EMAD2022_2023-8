import 'dart:convert';

import 'package:frontend_sws/services/entity/Area.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;


import '../util/QueryStringUtil.dart';
import 'RestURL.dart';
import 'UserService.dart';

class AreeService {
  final log = Logger('AreeServiceLoger');
  UserService userService = UserService();


  Future<List<Area>?> areeList(String? name) async {
    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();
      if (name != null) {
        queryStringUtil.add("name", name);
      }
      Uri u = Uri.parse(
          "${RestURL.areeService}?${queryStringUtil.getQueryString()}");

      var response = await http.get(
          u,
          headers: RestURL.defaultHeader);

      if (response.statusCode == 200) {
        var l = json.decode(utf8.decode(response.bodyBytes));
        return List<Area>.from(l.map((model) => Area.fromJson(model)));

      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Area?> getArea(String id) async {
    try {
      var response = await http.get(
          Uri.parse("${RestURL.areeService}/$id"),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return areaFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<Area?> createArea(Area area) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse(RestURL.areeService),
          body: areaToJson(area), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return areaFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
  Future<bool> deleteArea(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.areeService}/$id"),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }
  Future<Area?> editArea(Area area) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.areeService}/${area.id}"),
          body: areaToJson(area),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return areaFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

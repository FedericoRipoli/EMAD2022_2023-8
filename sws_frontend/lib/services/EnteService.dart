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
}

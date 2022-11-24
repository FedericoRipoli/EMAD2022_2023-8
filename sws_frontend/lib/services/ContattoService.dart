import 'dart:convert';

import 'package:frontend_sws/services/entity/Contatto.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'RestURL.dart';
import 'UserService.dart';
import 'dto/ListResponse.dart';

class EnteService {
  final log = Logger('ContattoServiceLogger');
  UserService userService = UserService();

  Future<List<Contatto>?> contattoList(String? idEnte,int? page) async {
    try {
      List<String> queryArr = [];
      String query = "";
      if (idEnte != null) {
        queryArr.add("idEnte=$idEnte");
      }
      if (page != null) {
        queryArr.add("page=$page");
      } else {
        queryArr.add(RestURL.queryRemovePagination);
      }
      Uri u = Uri.parse("${RestURL.contattoService}?$query");
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
}

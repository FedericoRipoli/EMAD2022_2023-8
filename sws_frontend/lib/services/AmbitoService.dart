import 'dart:convert';

import 'package:frontend_sws/services/entity/Ambito.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;


import 'RestURL.dart';
import 'UserService.dart';

class AmbitoService {
  final log = Logger('AmbitoServiceLoger');
  UserService userService = UserService();


  Future<List<Ambito>?> ambitoList() async {
    try {

      var response = await http.get(
          Uri.parse(RestURL.ambitoService),
          headers: RestURL.defaultHeader);

      if (response.statusCode == 200) {
        var l = json.decode(response.body);
        return List<Ambito>.from(l.map((model) => Ambito.fromJson(model)));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

import 'dart:convert';

import 'package:frontend_sws/services/entity/Area.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;


import 'RestURL.dart';
import 'UserService.dart';

class AreeService {
  final log = Logger('AmbitoServiceLoger');
  UserService userService = UserService();


  Future<List<Area>?> ambitoList() async {
    try {

      var response = await http.get(
          Uri.parse(RestURL.areeService),
          headers: RestURL.defaultHeader);

      if (response.statusCode == 200) {
        var l = json.decode(response.body);
        return List<Area>.from(l.map((model) => Area.fromJson(model)));

      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}

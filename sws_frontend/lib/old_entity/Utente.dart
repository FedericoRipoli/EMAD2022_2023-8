import 'package:flutter/material.dart';

import 'Ente.dart';

class Utente extends StatelessWidget {
  final String id, username, password;
  final Ente? ente;
  final bool admin;
  const Utente(
      {Key? key,
      required this.id,
      required this.username,
      required this.password,
      this.ente,
      required this.admin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

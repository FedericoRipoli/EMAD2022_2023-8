import 'package:flutter/material.dart';

import 'Ente.dart';

class Contatto extends StatefulWidget {
  final String id;
  final String denominazione, email, cellulare, telefono, pec, sitoWeb;
  final Ente enteProprietario;

  const Contatto(
      {Key? key,
      required this.id,
      required this.denominazione,
      required this.email,
      required this.cellulare,
      required this.telefono,
      required this.pec,
      required this.sitoWeb,
      required this.enteProprietario})
      : super(key: key);

  @override
  State<Contatto> createState() => _ContattoState();
}

class _ContattoState extends State<Contatto> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

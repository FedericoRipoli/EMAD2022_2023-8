import 'package:flutter/material.dart';

class Contatto extends StatefulWidget {
  final String id;
  final String? denominazione, email, cellulare, telefono, pec, sitoWeb;

  const Contatto(
      {Key? key,
      required this.id,
      this.denominazione,
      this.email,
      this.cellulare,
      this.telefono,
      this.pec,
      this.sitoWeb})
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

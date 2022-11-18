import 'package:flutter/material.dart';
import 'Contatto.dart';

class Ente extends StatefulWidget {
  final String id;
  final String? denominazione, descrizione, piva, cf;
  final Contatto? contatto;
  final ImageIcon? logo;
  final List<AssetImage>? immagini;
  final List<Contatto>? contatti;

  const Ente(
      {Key? key,
      required this.id,
      this.denominazione,
      this.descrizione,
      this.piva,
      this.cf,
      this.contatto,
      this.logo,
      this.immagini,
      this.contatti})
      : super(key: key);

  @override
  State<Ente> createState() => _EnteState();
}

class _EnteState extends State<Ente> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

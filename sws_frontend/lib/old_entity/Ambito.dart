import 'package:flutter/material.dart';

class Ambito extends StatefulWidget {
  final String id, nome, idPadre;
  final Ambito padre;
  final List<Ambito> figli;
  const Ambito(
      {Key? key,
      required this.id,
      required this.nome,
      required this.idPadre,
      required this.padre,
      required this.figli})
      : super(key: key);

  @override
  State<Ambito> createState() => _AmbitoState();
}

class _AmbitoState extends State<Ambito> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

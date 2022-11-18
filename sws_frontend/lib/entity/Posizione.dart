import 'package:flutter/material.dart';

class Posizione extends StatelessWidget {
  final String id, indirizzo, latitudine, longitudine;
  const Posizione(
      {Key? key,
      required this.id,
      required this.indirizzo,
      required this.latitudine,
      required this.longitudine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

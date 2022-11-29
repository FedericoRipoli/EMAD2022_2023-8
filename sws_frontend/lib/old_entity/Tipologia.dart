import 'package:flutter/material.dart';

class Tipologia extends StatelessWidget {
  final String id, nome, idPadre;
  final List<Tipologia>? figli;
  final Tipologia? padre;
  const Tipologia(
      {Key? key,
      required this.id,
      required this.nome,
      required this.idPadre,
      this.figli,
      this.padre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

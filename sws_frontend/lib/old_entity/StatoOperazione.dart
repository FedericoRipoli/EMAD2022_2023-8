import 'package:flutter/material.dart';

class StatoOperazione extends StatelessWidget {
  static const String DA_APPROVARE = "Da approvare";
  static const String APPROVATO = "Approvato";
  static const String IN_MODIFICA = "In modifica";
  static const String ANNULLATO = "Annullato";

  final String text;
  const StatoOperazione({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

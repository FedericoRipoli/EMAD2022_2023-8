import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/old_entity/Ente.dart';
import 'package:frontend_sws/old_entity/StatoOperazione.dart';
import 'package:frontend_sws/old_entity/Tipologia.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'Ambito.dart';
import 'Contatto.dart';
import 'Posizione.dart';

double? width;
double? height;

class Servizio extends StatefulWidget {
  final String id;
  final String? nome, contenuto, tags;
  final List<AssetImage>? immagini;
  final List<Contatto>? contatti;
  final bool visibile;
  final Ente? ente;
  final List<Posizione>? posizioni;
  final StatoOperazione? stato;
  final String? note;
  final Ambito? ambito;
  final Tipologia? tipologia;
  final DateTime? dataCreazione, dataUltimaModifica;

  const Servizio(
      {Key? key,
      required this.id,
      this.nome,
      this.contenuto,
      this.tags,
      this.immagini,
      this.contatti,
      required this.visibile,
      this.ente,
      this.posizioni,
      this.stato,
      this.note,
      this.ambito,
      this.tipologia,
      this.dataCreazione,
      this.dataUltimaModifica})
      : super(key: key);

  @override
  State<Servizio> createState() => _ServizioState();
}

class _ServizioState extends State<Servizio> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

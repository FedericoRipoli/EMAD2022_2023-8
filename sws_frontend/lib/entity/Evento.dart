import 'package:flutter/material.dart';
import 'package:frontend_sws/entity/Tipologia.dart';

import 'Ambito.dart';
import 'Contatto.dart';
import 'Ente.dart';
import 'Posizione.dart';
import 'StatoOperazione.dart';

class Evento extends StatelessWidget {
  final String id, nome, contenuto, tags;
  final List<AssetImage>? immagini;
  final List<Posizione>? posizioni;
  final List<Contatto>? contatti;
  final DateTime? dataInizio, dataFine;
  final StatoOperazione? state;
  final String? note;
  final Ambito? ambito;
  final Tipologia? tipologia;
  final Ente? ente;
  final DateTime? dataCreazione, dataUltimaModifica;

  const Evento(
      {Key? key,
      required this.id,
      required this.nome,
      required this.contenuto,
      required this.tags,
      this.immagini,
      this.posizioni,
      this.contatti,
      this.dataInizio,
      this.dataFine,
      this.state,
      this.note,
      this.ambito,
      this.tipologia,
      this.ente,
      this.dataCreazione,
      this.dataUltimaModifica})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfoEvento()),
          );
        },
        child: Container(
          width: 330,
          height: 240,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  width: 335,
                  height: 110,
                  child: Image.asset(
                    "assets/images/event_default.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Column(children: [
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Chip(
                        label: Text(id),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Chip(
                        label: Text(tags),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Chip(
                        label: Text(tags),
                      ),
                    ),
                  ]),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      child: Text(
                        nome,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                ])
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class InfoEvento extends StatelessWidget {
  const InfoEvento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text("Sezione Info evento"),
      ),
    );
  }
}

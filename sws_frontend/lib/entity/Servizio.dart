import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/entity/Ente.dart';
import 'package:frontend_sws/entity/StatoOperazione.dart';
import 'package:frontend_sws/entity/Tipologia.dart';
import 'package:frontend_sws/main.dart';
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
  bool chooseState = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoServizio(servizio: widget)),
          );
        },
        child: SizedBox(
          width: 330,
          height: 240,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  width: 335,
                  height: 110,
                  child: Image.asset(
                    "assets/images/service_default.png",
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
                        label: Text("ambito"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Chip(
                        label: Text("tipologia!"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Chip(
                        label: Text(widget.tags!),
                      ),
                    ),
                  ]),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      child: Text(
                        widget.nome!,
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

class InfoServizio extends StatelessWidget {
  final Servizio servizio;
  const InfoServizio({Key? key, required this.servizio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: AppBar(
            leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, size: 32, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            backgroundColor: appTheme.primaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
            )),
          ),
        ),
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          hoverElevation: 0,
          onPressed: () {},
          backgroundColor: Colors.green,
          label: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.call,
                  size: 20,
                ),
              ),
              Text(
                "Contatta",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servizio.nome!,
                    style: TextStyle(
                        color: appTheme.primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Ente",
                      style: TextStyle(
                          color: appTheme.primaryColor, fontSize: 22)),
                  const SizedBox(height: 18),
                  const Text("Descrizione",
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 32,
                            color: appTheme.primaryColor,
                          ),
                          const Text(
                            'Dal 22 dicembre',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 32,
                            color: appTheme.primaryColor,
                          ),
                          const Text(
                            '19:00 - 21:00',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ), // riga dei chip
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text("tipologia"),
                        labelStyle: TextStyle(
                            color: appTheme.primaryColor, fontSize: 18),
                      ),
                      Chip(
                        label: Text("ambito"),
                        labelStyle: TextStyle(
                            color: appTheme.primaryColor, fontSize: 18),
                      ),
                      const Chip(
                        label: Text("stato"),
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 18),
                        backgroundColor: Colors.green,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: appTheme.primaryColor,
                      ),
                      Text(
                        'Dove viene erogato il servizio?',
                        style: TextStyle(
                            fontSize: 20, color: appTheme.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                            Text(
                                "Via Garibaldi 2\nVia Roma 3\nPiazza Plebiscito 51",
                                style: TextStyle(fontSize: 16))
                          ])),
                      Flexible(
                        child: Image.asset("assets/images/welfare.jpg"),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outlined,
                        size: 20,
                        color: appTheme.primaryColor,
                      ),
                      Text(
                        'Hai bisogno di maggiori informazioni?',
                        style: TextStyle(
                            fontSize: 20, color: appTheme.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("telefono, email ....")
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:frontend_sws/entity/Ente.dart';
import 'Contatto.dart';

class Servizio extends StatelessWidget {
  final String id;
  final String? nome, contenuto;
  final List<AssetImage>? immagini;
  final List<Contatto>? contatti;
  final bool visibile;
  final String? tags, ambito, tipologia;
  final Ente? ente;
  /*
  * private List<Contatto> contatti;
     private Ambito ambito;
    @OneToOne
    private Tipologia tipologia;
    @OneToOne
    private Ente ente;
    @OneToMany
    private List<OperazioneServizio> operazioni;
  *
  * */

  const Servizio({
    Key? key,
    required this.id,
    this.nome,
    this.contenuto,
    this.immagini,
    this.contatti,
    required this.visibile,
    this.tags,
    this.ambito,
    this.tipologia,
    this.ente,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfoServizio()),
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
                        label: Text(ambito!),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Chip(
                        label: Text(tipologia!),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Chip(
                        label: Text(tags!),
                      ),
                    ),
                  ]),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      child: Text(
                        nome!,
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
  const InfoServizio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: Container());
  }
}

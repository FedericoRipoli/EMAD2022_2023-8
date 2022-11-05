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
        onTap: () {},
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
                    "assets/images/welfare.jpg",
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

/*
* Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: height! * .8 < 160 ? height! * .140 : 160,
                    width: width! * .8 < 250 ? width! * .8 : 250,
                    //   child:Image .asset(image,fit: BoxFit.cover,)
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image!), fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  height: 65,
                  width: width! * .8 < 250 ? width! * .8 : 250,
                  left: 5,
                  //right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.black12],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  right: 15,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              monthyear!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          discount!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ],
    );
* */

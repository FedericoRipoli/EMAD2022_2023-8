import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/entity/Ente.dart';
import 'package:frontend_sws/entity/StatoOperazione.dart';
import 'package:frontend_sws/entity/Tipologia.dart';
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
          width: 380,
          height: 320,
          child: GFCard(
            boxFit: BoxFit.cover,
            titlePosition: GFPosition.start,
            showOverlayImage: false,
            color: Colors.white,
            elevation: 14,
            title: GFListTile(
              avatar: GFAvatar(
                shape: GFAvatarShape.standard,
                backgroundColor: appTheme.primaryColor,
                child: const Text("AD"),
              ),
              titleText: widget.nome!,
              subTitleText: widget.tags!,
              icon: const Icon(Icons.accessible),
            ),
            content: Text(widget.contenuto!),
            buttonBar: GFButtonBar(
              children: <Widget>[
                Chip(
                  label: Text("Ambito"),
                ),
                Chip(label: Text("Tipologia")),
                Chip(label: Text(widget.tags!)),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: GFAppBar(
          title: Text("Info Servizio"),
          leading: GFIconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            type: GFButtonType.transparent,
          ),
          searchBar: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: appTheme.primaryColor,
        ),
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 8,
          hoverElevation: 8,
          onPressed: () {},
          backgroundColor: Colors.green.shade700,
          label: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: Icon(
                  Icons.call,
                  size: 18,
                ),
              ),
              Text(
                "Contatta",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: WaveClipperOne(flip: true),
                      child: Container(
                        height: 80, //400
                        color: appTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                GFListTile(
                  avatar: const GFAvatar(
                    shape: GFAvatarShape.standard,
                    child: Text("EA"),
                  ),
                  color: Colors.white,
                  title: GFTypography(
                    text: 'Nome Servizio',
                    type: GFTypographyType.typo2,
                    showDivider: false,
                    textColor: appTheme.primaryColor,
                  ),
                  subTitle: GFTypography(
                    text: 'Nome Ente',
                    type: GFTypographyType.typo4,
                    icon: Icon(
                      Icons.home_work_rounded,
                      color: appTheme.primaryColor,
                    ),
                    dividerColor: appTheme.primaryColor,
                    textColor: appTheme.primaryColor,
                    fontWeight: FontWeight.normal,
                    dividerWidth: 130.0,
                  ),
                ),
                const SizedBox(height: 20),
                GFListTile(
                  description: GFTypography(
                    text: descrizione,
                    type: GFTypographyType.typo4,
                    fontWeight: FontWeight.normal,
                    showDivider: false,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Chip(
                      elevation: 6,
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.white,
                      shadowColor: Colors.black,
                      avatar: Icon(
                        Icons.access_time,
                        color: appTheme.primaryColor,
                      ),
                      label: const Text(
                        '12:00 - 15:00',
                        style: TextStyle(fontSize: 20),
                      ), //Text
                    ),
                    Chip(
                      elevation: 8,
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.white,
                      shadowColor: Colors.black,
                      avatar: Icon(
                        Icons.calendar_month,
                        color: appTheme.primaryColor,
                      ),
                      label: const Text(
                        'dal 22 Dicembre',
                        style: TextStyle(fontSize: 20),
                      ), //Text
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Chip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        "Ambito",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Chip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        "Tipologia",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Chip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        "#TAGS",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Chip(
                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.green.shade700,
                      label: Text(
                        "Active",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                GFListTile(
                  title: GFTypography(
                    text: 'Dove puoi usufruire del servizio?',
                    type: GFTypographyType.typo2,
                    showDivider: false,
                    textColor: appTheme.primaryColor,
                  ),
                  icon: Icon(
                    Icons.location_on,
                    color: appTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

String descrizione =
    "REST has quickly become the de-facto standard for building web services on the web because they’re easy to build and easy to consume. There’s a much larger discussion to be had about how REST fits in the world of microservices, but — for this tutorial — let’s just look at building RESTful services.\n\nWhy REST? REST embraces the precepts of the web, including its architecture, benefits, and everything else. This is no surprise given its author, Roy Fielding, was involved in probably a dozen specs which govern how the web operates.What benefits? The web and its core protocol, HTTP, provide a stack of features:";

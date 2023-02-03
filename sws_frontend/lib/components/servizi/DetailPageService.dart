import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend_sws/screens/ente/InfoEnte.dart';

import '../generali/ImageVisualizer.dart';

class DetailPageService extends StatefulWidget {
  Servizio servizio;

  DetailPageService({super.key, required this.servizio});

  @override
  _DetailPageServiceState createState() => _DetailPageServiceState();
}

class _DetailPageServiceState extends State<DetailPageService> {
  bool isContactDisable = true;
  bool isEmailDisable = true;
  bool isSitoDisable = true;

  @override
  void initState() {
    setDisable();
    super.initState();
  }

  void setDisable() {
    if (widget.servizio.contatto?.telefono != null) {
      setState(() {
        isContactDisable = false;
      });
    } else {
      setState(() {
        isContactDisable = true;
      });
    }
    if (widget.servizio.contatto?.email != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(widget.servizio.contatto!.email!)) {
      setState(() {
        isEmailDisable = false;
      });
    } else {
      setState(() {
        isEmailDisable = true;
      });
    }
    if (widget.servizio.contatto?.sitoWeb != null) {
      setState(() {
        isSitoDisable = false;
      });
    } else {
      setState(() {
        isSitoDisable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPaddingElement = const EdgeInsets.fromLTRB(15, 0, 15, 0);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipperOne(),
                      child: Container(
                        height: 150,
                        color: AppColors.logoBlue,
                        child: Center(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              minVerticalPadding: 8,
                              title: Text(
                                widget.servizio.nome,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              subtitle: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InfoEnte(
                                              idEnte: widget.servizio.struttura!
                                                  .ente!.id!)),
                                    );
                                  },
                                  child: Wrap(
                                    children: [
                                      const Icon(
                                        Icons.home_work,
                                        color: AppColors.logoCadmiumOrange,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        widget.servizio.struttura!.ente!
                                                .denominazione ??
                                            "",
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                AppColors.logoCadmiumOrange,
                                            decorationThickness: 5,
                                            color: AppColors.detailBlue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Informazioni",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.logoCadmiumOrange),
                ),
                GFListTile(
                  title: Text(
                    widget.servizio.nome,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  subTitle: Text(
                    widget.servizio.struttura?.denominazione != null
                        ? "Struttura: ${widget.servizio.struttura!.denominazione!}"
                        : "Struttura non disponibile",
                    style: const TextStyle(fontSize: 16),
                  ),
                  description: Text(
                    widget.servizio.struttura?.posizione?.indirizzo != null
                        ? widget.servizio.struttura!.posizione!.indirizzo!
                        : "Indirizzo non disponibile",
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.logoCadmiumOrange,
                  ),
                ),
                GFListTile(
                  title: Text(
                    (widget.servizio.aree != null ||
                            widget.servizio.aree!.isNotEmpty)
                        ? widget.servizio.aree!.map((e) => e.nome).join(", ")
                        : "Nessuna area di riferimento",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  subTitle: Text(
                    isContactDisable
                        ? "Telefono non disponibile"
                        : "Telefono: +39 ${widget.servizio.contatto?.telefono!}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  description: Text(
                    isEmailDisable
                        ? "Email non disponibile"
                        : "Email: ${widget.servizio.contatto?.email!}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  icon: const Icon(
                    Icons.contact_phone,
                    color: AppColors.logoCadmiumOrange,
                  ),
                ),
                GFListTile(
                  description: Text(
                    (widget.servizio.contenuto != null)
                        ? widget.servizio.contenuto!
                        : "Nessuna descrizione",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    //maxLines: 4,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
                GFListTile(
                  description: TextButton(
                      onPressed: () => isSitoDisable
                          ? null
                          : () async {
                              Uri url = Uri.parse(
                                  "https:${widget.servizio.contatto?.sitoWeb}");
                              await launchUrl(url);
                            },
                      child: Text(
                        isSitoDisable
                            ? "Nessun Sito WEB"
                            : widget.servizio.contatto!.sitoWeb!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryBlue,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Trovaci sulla mappa",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.logoCadmiumOrange),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: 200,
                  child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(
                            double.parse(widget
                                .servizio.struttura!.posizione!.latitudine!),
                            double.parse(widget
                                .servizio.struttura!.posizione!.longitudine!)),
                        zoom: 15.0,
                        maxZoom: 30.0,
                        enableScrollWheel: true,
                        scrollWheelVelocity: 0.005,
                      ),
                      children: [
                        TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                        MarkerClusterLayerWidget(
                          options: MarkerClusterLayerOptions(
                            spiderfyCircleRadius: 80,
                            spiderfySpiralDistanceMultiplier: 2,
                            circleSpiralSwitchover: 12,
                            maxClusterRadius: 120,
                            rotate: true,
                            size: const Size(40, 40),
                            anchor: AnchorPos.align(AnchorAlign.center),
                            fitBoundsOptions: const FitBoundsOptions(
                              padding: EdgeInsets.all(50),
                              maxZoom: 15,
                            ),
                            markers: [
                              Marker(
                                point: LatLng(
                                    double.parse(widget.servizio.struttura!
                                        .posizione!.latitudine!),
                                    double.parse(widget.servizio.struttura!
                                        .posizione!.longitudine!)),
                                builder: (ctx) => Icon(
                                  widget.servizio.customIcon != null
                                      ? widget.servizio.getIconData()
                                      : Icons.location_on,
                                  size: 50,
                                  color: AppColors.logoCadmiumOrange,
                                ),
                                width: 50.0,
                                height: 50.0,
                              )
                            ],
                            polygonOptions: const PolygonOptions(
                                borderColor: AppColors.logoBlue,
                                color: Colors.black12,
                                borderStrokeWidth: 3),
                            builder: (context, markers) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.logoBlue),
                                child: Center(
                                  child: Text(
                                    markers.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 12,
                ),
                widget.servizio.immagine != null
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: ImageVisualizer(
                          tag: "Locandina",
                          imageData: widget.servizio.immagine!.imageData,
                        ))
                    : const Text("Nessuna immagine",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.black,
                        )),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: defaultPaddingElement,
                            child: CustomButton(
                              onPressed: () => isContactDisable
                                  ? null
                                  : () async {
                                      String number =
                                          widget.servizio.contatto!.telefono!;
                                      Uri tel = Uri.parse("tel:$number");
                                      await launchUrl(tel);
                                    },
                              textButton: 'Telefona',
                              bgColor: isContactDisable
                                  ? Colors.grey
                                  : AppColors.logoBlue,
                              icon: Icons.phone,
                            ))),
                    Expanded(
                        child: Padding(
                            padding: defaultPaddingElement,
                            child: CustomButton(
                              textButton: "E-mail",
                              onPressed: () => isEmailDisable
                                  ? null
                                  : () async {
                                      String email = Uri.encodeComponent(
                                          widget.servizio.contatto!.email!);
                                      String subject = Uri.encodeComponent(
                                          "Informazioni su ${widget.servizio.nome}");
                                      String body = Uri.encodeComponent(
                                          "Salve, la contatto in merito...");
                                      Uri mail = Uri.parse(
                                          "mailto:$email?subject=$subject&body=$body");
                                      await launchUrl(mail);
                                    },
                              icon: Icons.email,
                              bgColor: isEmailDisable
                                  ? Colors.grey
                                  : AppColors.logoBlue,
                            )))
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}

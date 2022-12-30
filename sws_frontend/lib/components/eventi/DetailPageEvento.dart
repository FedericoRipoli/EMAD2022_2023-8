import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/components/generali/ImageVisualizer.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/entity/Evento.dart';
import '../../util/ManageDate.dart';

class DetailPageEvento extends StatefulWidget {
  Evento evento;

  DetailPageEvento({super.key, required this.evento});

  @override
  _DetailPageEventoState createState() => _DetailPageEventoState();
}

class _DetailPageEventoState extends State<DetailPageEvento> {
  bool isContactDisable = true;
  bool isEmailDisable = true;

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
                        height: 100,
                        color: AppColors.logoBlue,
                        child: Center(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.evento.nome,
                              style: const TextStyle(
                                  color: AppColors.white,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
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
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.logoCadmiumOrange),
                ),
                GFListTile(
                  title: Text(
                    widget.evento.nome,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  description: Text(
                    widget.evento.dataInizio != null
                        ? "Da ${ManageDate.formatDate(DateTime.parse(widget.evento.dataInizio!), context)}\na ${ManageDate.formatDate(DateTime.parse(widget.evento.dataFine!), context)}"
                        : "Data non disponibile",
                    style: const TextStyle(fontSize: 16),
                  ),
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.logoCadmiumOrange,
                  ),
                ),
                GFListTile(
                  description: Text(
                    (widget.evento.contenuto != null)
                        ? widget.evento.contenuto!
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
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Guarda sulla mappa",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.logoCadmiumOrange),
                ),
                const SizedBox(
                  height: 6,
                ),
                /*SizedBox(
                  height: 200,
                  child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(
                            double.parse(widget.evento.posizione!.latitudine!),
                            double.parse(
                                widget.evento.posizione!.longitudine!)),
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
                                    double.parse(
                                        widget.evento.posizione!.latitudine!),
                                    double.parse(
                                        widget.evento.posizione!.longitudine!)),
                                builder: (ctx) => const Icon(
                                  Icons.location_on,
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
                ),*/
                const SizedBox(
                  height: 12,
                ),
                widget.evento.locandina != null
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.memory(
                            base64Decode(widget.evento.locandina!.imageData)),
                      )
                    : const Text("Nessuna immagine",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.logoCadmiumOrange,
                        )),
                const SizedBox(
                  height: 12,
                ),
                ImageVisualizer(tag: "ciao"),
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
                                          widget.evento.contatto!.telefono!;
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
                                          widget.evento.contatto!.email!);
                                      String subject = Uri.encodeComponent(
                                          "Informazioni su ${widget.evento.nome}");
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
              ],
            ),
          ),
        ));
  }
}

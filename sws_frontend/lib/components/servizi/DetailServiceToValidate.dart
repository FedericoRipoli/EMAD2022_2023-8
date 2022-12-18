import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/components/generali/ChipGenerale.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailServiceToValidate extends StatefulWidget {
  Servizio servizio;

  DetailServiceToValidate({super.key, required this.servizio});
  @override
  _DetailServiceToValidateState createState() =>
      _DetailServiceToValidateState();
}

class _DetailServiceToValidateState extends State<DetailServiceToValidate> {
  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPaddingElement = const EdgeInsets.fromLTRB(30, 0, 30, 0);
    return Scaffold(
        //backgroundColor: Colors.black,
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "stato: ${widget.servizio.stato}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0,
                              color: AppColors.logoBlue,
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Text(
                            widget.servizio.nome,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            (widget.servizio.aree != null ||
                                    widget.servizio.aree!.isNotEmpty)
                                ? widget.servizio.aree!
                                    .map((e) => e.nome)
                                    .join(", ")
                                : "Nessuna area di riferimento",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.servizio.struttura?.denominazione != null
                                ? widget.servizio.struttura!.denominazione!
                                : "Struttura non disponibile",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                              letterSpacing: 0.27,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.servizio.struttura?.posizione?.indirizzo !=
                                    null
                                ? widget
                                    .servizio.struttura!.posizione!.indirizzo!
                                : "Indirizzo non disponibile",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              letterSpacing: 0.57,
                              color: AppColors.logoBlue,
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 220,
                            child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(
                                      double.parse(widget.servizio.struttura!
                                          .posizione!.latitudine!),
                                      double.parse(widget.servizio.struttura!
                                          .posizione!.longitudine!)),
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
                                      anchor:
                                          AnchorPos.align(AnchorAlign.center),
                                      fitBoundsOptions: const FitBoundsOptions(
                                        padding: EdgeInsets.all(50),
                                        maxZoom: 15,
                                      ),
                                      markers: [
                                        Marker(
                                          point: LatLng(
                                              double.parse(widget
                                                  .servizio
                                                  .struttura!
                                                  .posizione!
                                                  .latitudine!),
                                              double.parse(widget
                                                  .servizio
                                                  .struttura!
                                                  .posizione!
                                                  .longitudine!)),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.logoBlue),
                                          child: Center(
                                            child: Text(
                                              markers.length.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipGenerale(
                                label:
                                    widget.servizio.contatto?.telefono != null
                                        ? widget.servizio.contatto!.telefono!
                                        : "Nessun recapito",
                                icon: Icons.phone,
                                backgroundColor: AppColors.detailBlue,
                              ),
                              const SizedBox(height: 10),
                              ChipGenerale(
                                label: widget.servizio.contatto?.email != null
                                    ? widget.servizio.contatto!.email!
                                    : "Nessun e-mail",
                                icon: Icons.mail,
                                backgroundColor: AppColors.detailBlue,
                              ),

                              /*Text("E-mail:\n${(widget.servizio.contatto?.email != null) ?
                                          widget.servizio.contatto!.email!
                                          : "nessuna e-mail"}",
                                      textAlign: TextAlign.left,
                                    )*/
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const Text(
                            "Informazioni sul servizio",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0.57,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: defaultPaddingElement,
                            child: Text(
                              (widget.servizio!.contenuto != null)
                                  ? widget.servizio.contenuto!
                                  : "Nessuna descrizione",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                              //maxLines: 4,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (widget.servizio.note != null)
                            const Text(
                              "Note inviate",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.57,
                                color: Colors.black,
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const Text(
                            "Note aggiuntive",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0.57,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: defaultPaddingElement,
                            child: Text(
                              (widget.servizio!.note != null &&
                                      widget.servizio!.note!.isNotEmpty)
                                  ? widget.servizio.note!
                                  : "Nessuna nota presente",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                              //maxLines: 4,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ));
                },
                childCount: 1, // 1000 list items
              ),
            ),
          ],
        ));
  }
}

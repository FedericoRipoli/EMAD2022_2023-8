import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPageService extends StatefulWidget {
  Servizio servizio;

  DetailPageService({super.key, required this.servizio});

  @override
  _DetailPageServiceState createState() => _DetailPageServiceState();
}

class _DetailPageServiceState extends State<DetailPageService> {
  final double infoHeight = 364.0;
  bool isContactDisable = true;
  bool isEmailDisable = true;

  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPaddingElement = const EdgeInsets.fromLTRB(30, 0, 30, 0);
    return Scaffold(
        //backgroundColor: Colors.black,
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                floating: false,
                centerTitle: true,
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  //color: const Color.fromARGB(50, 255, 255, 255),
                  child: Text(
                    widget.servizio.nome,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.black,
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.16,
                flexibleSpace: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0)),
                    child:
                        Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
                  ),
                )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(children: [
                                  const Icon(
                                    Icons.accessibility,
                                    color: AppColors.logoCadmiumOrange,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    (widget.servizio.aree != null ||
                                            widget.servizio.aree!.isNotEmpty)
                                        ? widget.servizio.aree!
                                            .map((e) => e.nome)
                                            .join(", ")
                                        : "Nessuna area di riferimento",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]),
                                Wrap(
                                  children: [
                                    const Icon(
                                      Icons.home_work,
                                      color: AppColors.logoCadmiumOrange,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      widget.servizio.struttura
                                                  ?.denominazione !=
                                              null
                                          ? "Struttura: ${widget.servizio.struttura!.denominazione!}"
                                          : "Struttura non disponinile",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 16,
                                        letterSpacing: 0.27,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: AppColors.logoCadmiumOrange,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      widget.servizio.struttura?.posizione
                                                  ?.indirizzo !=
                                              null
                                          ? widget.servizio.struttura!
                                              .posizione!.indirizzo!
                                          : "Indirizzo non disponibile",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 16,
                                        letterSpacing: 0.57,
                                        color: AppColors.logoBlue,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 200,
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
                                    anchor: AnchorPos.align(AnchorAlign.center),
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
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: defaultPaddingElement,
                                    child: CustomButton(
                                      onPressed: () => isContactDisable
                                          ? null
                                          : () async {
                                              String number = widget
                                                  .servizio.contatto!.telefono!;
                                              Uri tel =
                                                  Uri.parse("tel:$number");
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
                                              String email =
                                                  Uri.encodeComponent(widget
                                                      .servizio
                                                      .contatto!
                                                      .email!);
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
                          height: 30,
                        ),
                        const Text(
                          "Informazioni sul servizio",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                            (widget.servizio.contenuto != null)
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
          ],
        ));
  }
}

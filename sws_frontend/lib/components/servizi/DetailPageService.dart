import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPageService extends StatefulWidget {
  Servizio servizio;

  DetailPageService({Key? key, required this.servizio}) {}

  @override
  _DetailPageServiceState createState() => _DetailPageServiceState();
}

class _DetailPageServiceState extends State<DetailPageService>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  bool isContactDisable = true;
  bool isEmailDisable = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    isContactDisable = (widget.servizio.contatto?.telefono == null) ||
        (widget.servizio.contatto!.telefono!.isEmpty);
    isEmailDisable = (widget.servizio.contatto?.email == null) ||
        (widget.servizio.contatto!.email!.isEmpty);

    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

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
                  color: Color.fromARGB(80, 255, 255, 255),
                  child: Text(
                    widget.servizio.nome,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.26,
                flexibleSpace: Container(
                  color: Colors.black,
                  padding:
                      EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0)),
                    child: Image.asset(
                        "assets/images/servizi_sociali_default.jpg",
                        fit: BoxFit.cover),
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
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 5),
                            child: Column(
                              children: [
                                Text(
                                  (widget.servizio.aree != null ||
                                          widget.servizio.aree!.isNotEmpty)
                                      ? widget.servizio.aree!
                                          .map((e) => e.nome)
                                          .join(", ")
                                      : "Nessuna area di riferimento",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  widget.servizio.struttura?.denominazione !=
                                          null
                                      ? widget
                                          .servizio.struttura!.denominazione!
                                      : "Struttura non disponinile",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 18,
                                    letterSpacing: 0.27,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  widget.servizio.struttura?.posizione
                                              ?.indirizzo !=
                                          null
                                      ? widget.servizio.struttura!.posizione!
                                          .indirizzo!
                                      : "Indirizzo non disponibile",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 16,
                                    letterSpacing: 0.57,
                                    color: AppColors.logoBlue,
                                  ),
                                )
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
                                        builder: (ctx) =>  Icon(
                                          widget.servizio.customIcon!=null? widget.servizio.getIconData() : Icons.location_on,
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
                                    child: ElevatedButton.icon(
                                        onPressed: isContactDisable
                                            ? null
                                            : () async {
                                                String number = widget.servizio
                                                    .contatto!.telefono!;
                                                Uri tel =
                                                    Uri.parse("tel:$number");
                                                await launchUrl(tel);
                                              },
                                        icon: const Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                        label: const Text("Chiama")))),
                            Expanded(
                                child: Padding(
                                    padding: defaultPaddingElement,
                                    child: ElevatedButton.icon(
                                        onPressed: isEmailDisable
                                            ? null
                                            : () async {
                                                String email =
                                                    Uri.encodeComponent(widget
                                                        .servizio
                                                        .contatto!
                                                        .email!);
                                                String subject =
                                                    Uri.encodeComponent(
                                                        "Informazioni su ${widget.servizio.nome}");
                                                String body = Uri.encodeComponent(
                                                    "Salve, la contatto in merito...");
                                                Uri mail = Uri.parse(
                                                    "mailto:$email?subject=$subject&body=$body");
                                                await launchUrl(mail);
                                              },
                                        icon: const Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        label: const Text("E-Mail"))))
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
                            fontSize: 16,
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

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.ice,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 9.0, right: 9.0, top: 4.0, bottom: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.blue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

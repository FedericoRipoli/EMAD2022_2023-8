import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/components/generali/CustomAvatar.dart';
import 'package:frontend_sws/components/loading/AllPageLoad.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:latlong2/latlong.dart';

import '../../../services/ServizioService.dart';
import '../../../services/entity/Servizio.dart';
import '../../../services/entity/Struttura.dart';
import '../../../theme/theme.dart';
import '../../servizi/CardServizio.dart';
import '../../servizi/ServizioListItem.dart';

class DetailPageStruttura extends StatefulWidget {
  final Struttura struttura;

  const DetailPageStruttura({Key? key, required this.struttura})
      : super(key: key);

  @override
  State<DetailPageStruttura> createState() => _DetailPageStrutturaState();
}

class _DetailPageStrutturaState extends State<DetailPageStruttura> {
  ServizioService servizioService = ServizioService();

  List<Servizio>? servizi = null;

  Future<void> _fetchServizi() async {
    try {
      servizi =
          (await servizioService.serviziListByStruttura(widget.struttura.id!))!;
    } catch (error) {
      print(error);
    }

    setState(() {});
  }

  @override
  void initState() {
    _fetchServizi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      height: 120,
                      color: AppColors.logoBlue,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.struttura.denominazione!,
                            style: const TextStyle(
                                color: AppColors.white,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const CustomAvatar(size: 32, icon: Icons.home_work)
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
                "Posizione",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.logoCadmiumOrange),
              ),
              GFListTile(
                description: Text(
                  widget.struttura?.posizione?.indirizzo != null
                      ? widget.struttura!.posizione!.indirizzo!
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
              SizedBox(
                height: 200,
                child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                          double.parse(
                              widget.struttura!.posizione!.latitudine!),
                          double.parse(
                              widget.struttura!.posizione!.longitudine!)),
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
                                      widget.struttura!.posizione!.latitudine!),
                                  double.parse(widget
                                      .struttura!.posizione!.longitudine!)),
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
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "I servizi offerti",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.logoCadmiumOrange),
              ),
              const SizedBox(
                height: 6,
              ),
              servizi != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: servizi!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardServizio(
                          idServizio: servizi![index].id!,
                          nomeServizio: servizi![index].nome,
                          ente: servizi![index].struttura!.ente!.denominazione,
                          aree: servizi![index].aree!,
                          posizione:
                              servizi![index].struttura?.posizione?.indirizzo,
                        );
                      })
                  : const Center(
                      child: Text(
                      "Nessun servizio",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.logoCadmiumOrange),
                    )),
            ],
          ),
        ));
  }
}

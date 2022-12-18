import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/components/servizi/DetailPageService.dart';
import 'package:frontend_sws/screens/InfoServizio.dart';
import 'package:latlong2/latlong.dart';

import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/mappa/MarkerMappa.dart';
import '../../components/mappa/PopupItemMappa.dart';
import '../../services/ServizioService.dart';
import '../../services/dto/PuntoMappaDTO.dart';
import '../../services/entity/Servizio.dart';
import '../../theme/theme.dart';

class MapTab extends StatefulWidget {
  Future<List<PuntoMappaDto>?> initCallMap;

  MapTab({Key? key, required this.initCallMap}) : super(key: key);

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  String? markerSelectedId;
  final PopupController _popupController = PopupController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PuntoMappaDto>?>(
        future: widget.initCallMap,
        builder: ((context, snapshot) {
          List<Widget> children = [];

          children.add(FlutterMap(
              options: MapOptions(
                center: LatLng(40.6824408, 14.7680961),
                zoom: 15.0,
                maxZoom: 30.0,
                enableScrollWheel: true,
                scrollWheelVelocity: 0.005,
                onTap: (_, __) {
                  _popupController.hideAllPopups();
                  markerSelectedId = null;
                  setState(() {});
                },
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    onMarkerTap: (marker) {
                      setState(() {
                        markerSelectedId =
                            (marker as MarkerMappa).punto.posizione;
                      });
                    },
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
                    markers: snapshot.hasData
                        ? snapshot.data!
                            .where((element) => element.posizione.isNotEmpty)
                            .map((e) => MarkerMappa(
                                punto: e,
                                isSelected: markerSelectedId != null &&
                                    markerSelectedId == e.posizione))
                            .toList()
                        : [],
                    polygonOptions: const PolygonOptions(
                        borderColor: AppColors.logoBlue,
                        color: Colors.black12,
                        borderStrokeWidth: 3),
                    popupOptions: PopupOptions(
                        popupState: PopupState(),
                        popupSnap: PopupSnap.markerTop,
                        popupController: _popupController,
                        popupBuilder: (_, marker) => Container(
                            color: Colors.transparent,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: (marker as MarkerMappa)
                                    .punto
                                    .punti
                                    .map((e) => PopupItemMappa(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InfoServizio(e.id)));
                                          },
                                          customIcon: e.getIconData(),
                                          nome: e.nome,
                                          ente: e.ente,
                                          struttura: e.struttura,
                                          indirizzo: e.indirizzo,
                                        ))
                                    .toList()))),
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
              ]));
          if (!snapshot.hasData && !snapshot.hasError) {
            children.add(const AllPageLoadTransparent());
          }
          return AbsorbPointer(
            absorbing: !(snapshot.hasData || snapshot.hasError),
            child: Stack(
              children: children,
            ),
          );
        }));
  }
}

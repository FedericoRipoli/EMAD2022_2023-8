import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/screens/servizi/InfoServizio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/mappa/MarkerMappa.dart';
import '../../components/mappa/PopupItemMappa.dart';
import '../../services/dto/PuntoMappaDTO.dart';
import '../../theme/theme.dart';

class MapTab extends StatefulWidget {
  Future<List<PuntoMappaDto>?> initCallMap;
  LatLng? centerPos;
  MapTab({Key? key, required this.initCallMap, this.centerPos }) : super(key: key);
  LatLng currentLatLng = LatLng(40.6824408, 14.7680961);
  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  String? markerSelectedId;
  final PopupController _popupController = PopupController();

  @override
  void initState() {
    super.initState();
    if(widget.centerPos != null)
      widget.currentLatLng = widget.centerPos!;
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
                center: widget.currentLatLng,
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
                                                        InfoServizio(idServizio: e.id)));
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
                MarkerLayer(
                  markers: (widget.currentLatLng.latitude != 40.6824408 &&
                      widget.currentLatLng.longitude != 14.7680961)? [
                    Marker(
                    point: widget.currentLatLng,
                    builder: (ctx) => const Icon(
                      Icons.man_outlined,
                      color: Colors.red,
                      size: 40,
                    )),
                  ]:[],
                )
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

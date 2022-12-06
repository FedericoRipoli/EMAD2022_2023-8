import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend_sws/components/aree/HorizontalListAree.dart';
import 'package:frontend_sws/components/eventi/CardEvento.dart';
import 'package:frontend_sws/components/loading/AllPageLoadTransparent.dart';
import 'package:frontend_sws/components/mappa/PopupItemMappa.dart';
import 'package:frontend_sws/components/servizi/CardServizio.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/ServizioService.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:latlong2/latlong.dart';
import '../components/mappa/MarkerMappa.dart';
import '../components/mappa/PopupItemMappa.dart';
import '../components/loading/AllPageLoad.dart';
import '../services/dto/PuntoMappaDTO.dart';
import '../theme/theme.dart';

class ServiziScreen extends StatefulWidget {
  final bool isServizi;
  const ServiziScreen({Key? key, required this.isServizi}) : super(key: key);

  @override
  State<ServiziScreen> createState() => _ServiziScreenState();
}

class _ServiziScreenState extends State<ServiziScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  bool isChecked = false;
  late Future<List<PuntoMappaDto>?> initCallMap;
  final PopupController _popupController = PopupController();
  final PagingController<int, Servizio> _pagingController =
  PagingController(firstPageKey: 0);
  ServizioService servizioService = ServizioService();
  String? markerSelectedId;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    tabController = TabController(length: 2, vsync: this);
    initCallMap = loadMapView();
  }

  Future<List<PuntoMappaDto>?>loadMapView() async {
    ServizioService servizioService=ServizioService();
    return servizioService.findPuntiMappa(null);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
      await servizioService.serviziList(null, pageKey,false);
      final isLastPage = newItems == null || newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems!);
      } else {
        pageKey++;
        _pagingController.appendPage(newItems, pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: GFAppBar(
          backgroundColor: AppColors.logoBlue,
          searchBar: true,
          searchHintText: "Cerca...",
          searchHintStyle: const TextStyle(fontSize: 18, color: Colors.white),
          searchTextStyle: const TextStyle(fontSize: 18, color: Colors.white),
          searchBarColorTheme: AppColors.white,
          //searchController: ,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          automaticallyImplyLeading: true,
          title: GFSegmentTabs(
            height: 38,
            tabController: tabController,
            tabBarColor: appTheme.primaryColor,
            labelColor: appTheme.primaryColor,
            labelPadding: const EdgeInsets.all(8),
            labelStyle: const TextStyle(fontSize: 16, fontFamily: "FredokaOne"),
            unselectedLabelStyle:
                const TextStyle(fontSize: 16, fontFamily: "FredokaOne"),
            unselectedLabelColor: GFColors.WHITE,
            indicator: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            indicatorPadding: const EdgeInsets.all(0.6),
            indicatorWeight: 4,
            indicatorSize: TabBarIndicatorSize.tab,
            border: Border.all(color: appTheme.primaryColor, width: 0.5),
            length: 2,
            tabs: const <Widget>[
              Text(
                "Lista",
              ),
              Text(
                "Mappa",
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_list_outlined,
                  color: AppColors.white,
                ))
          ],
        ),
      ),
      body: GFTabBarView(controller: tabController, children: <Widget>[
        searchList,
        FutureBuilder<List<PuntoMappaDto>?>(
            future: initCallMap,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              children.add( FlutterMap(

                  options: MapOptions(
                    center: LatLng(40.6824408, 14.7680961),
                    zoom: 15.0,
                    maxZoom: 30.0,
                    enableScrollWheel: true,
                    scrollWheelVelocity: 0.005,
                    onTap: (_, __) { _popupController
                        .hideAllPopups();
                    markerSelectedId=null;},
                  ),

                  children: [
                    TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                    MarkerClusterLayerWidget(

                      options: MarkerClusterLayerOptions(
                        onMarkerTap: (marker) {
                          setState(() {
                            markerSelectedId=(marker as MarkerMappa).punto.posizione;

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
                        markers: snapshot.hasData? snapshot.data!.where((element) => element.posizione.isNotEmpty).map((e) =>
                            MarkerMappa(punto:e,isSelected: markerSelectedId!=null && markerSelectedId==e.posizione)
                        ).toList():[],
                        polygonOptions: const PolygonOptions(
                            borderColor: Colors.blueAccent,
                            color: Colors.black12,
                            borderStrokeWidth: 3),
                        popupOptions: PopupOptions(

                            popupState: PopupState(),
                            popupSnap: PopupSnap.markerTop,
                            popupController: _popupController,
                            popupBuilder: (_, marker) => Container(
                            
                              color: Colors.transparent,
                              child:
                                    Column(
                                        mainAxisSize: MainAxisSize.min,

                                      children:(marker as MarkerMappa).punto.punti.map((e) =>
                                        PopupItemMappa(
                                          onTap: ()=>{},
                                          nome: e.nome,
                                          ente: e.ente,
                                          struttura: e.struttura,
                                          indirizzo: e.indirizzo,

                                        )
                                      ).toList()
                                    )



                            )),
                        builder: (context, markers) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue),
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
                ]
              )
              );
              if (!snapshot.hasData && !snapshot.hasError) {
                children.add(const AllPageLoadTransparent());
              }
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            }
            )),
      ]),
    );
  }



  late Widget searchList = Scaffold(
    body: widget.isServizi
        ? RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Column(children: <Widget>[
          Flexible(
            child: PagedListView<int, Servizio>(
              shrinkWrap: false,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Servizio>(
                  itemBuilder: (context, item, index) => CardServizio(
                    idServizio: item.id!,
                    nomeServizio: item.nome,
                    ente: "TODO nome ente",
                    area: item.aree!.map((e) => e.nome).join(", "),
                    posizione: item.struttura?.posizione?.indirizzo,
                  )),
            ),
          )
        ]))
        : Column(

        ),
  );
}
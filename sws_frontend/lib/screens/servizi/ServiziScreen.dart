import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
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
import '../../components/aree/DropdownAree.dart';
import '../../components/filtri/FilterBar.dart';
import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/mappa/MarkerMappa.dart';
import '../../components/mappa/PopupItemMappa.dart';
import '../../components/loading/AllPageLoad.dart';
import '../../services/dto/PuntoMappaDTO.dart';
import '../../theme/theme.dart';
import 'MapTab.dart';

class ServiziScreen extends StatefulWidget {
  bool isFilterOpen = true;
  TextEditingController filtroNomeController = TextEditingController();

  ServiziScreen({Key? key}) : super(key: key);

  @override
  State<ServiziScreen> createState() => _ServiziScreenState();
}

class _ServiziScreenState extends State<ServiziScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final PagingController<int, Servizio> _pagingController =
      PagingController(firstPageKey: 0);
  ServizioService servizioService = ServizioService();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    tabController = TabController(length: 2, vsync: this);
    initCallMap = loadMapView();
  }

  Future<List<PuntoMappaDto>?> loadMapView() async {
    ServizioService servizioService = ServizioService();
    return servizioService.findPuntiMappa(filterNome);
  }

  String? filterNome;
  late Future<List<PuntoMappaDto>?> initCallMap;

  void _filterNomeChange(String? text) {
    filterNome = text;
    _pullRefresh();
    initCallMap = loadMapView();
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await servizioService.serviziList(filterNome, pageKey, false);
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
      //resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: GFAppBar(
        centerTitle: true,
        backgroundColor: AppColors.logoBlue,
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
              onPressed: () {
                setState(() {
                  widget.isFilterOpen = !widget.isFilterOpen;
                });
              },
              icon: const Icon(
                Icons.search,
                color: AppColors.white,
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(widget.isFilterOpen ? 100 : 0),
          child: widget.isFilterOpen
              ? FilterBar(filters: [
                  TextFilter(
                      name: 'Cerca un servizio...',
                      textEditingController: widget.filtroNomeController,
                      positionType: GenericFilterPositionType.row,
                      valueChange: _filterNomeChange),
                ])
              : Container(),
        ),
      ),
      body: GFTabBarView(controller: tabController, children: <Widget>[
        searchList,
        MapTab(
          initCallMap: initCallMap,
        )
      ]),
    );
  }

  late Widget searchList = RefreshIndicator(
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
                      ente: item.struttura!.ente!.denominazione,
                      area: item.aree!.map((e) => e.nome).join(", "),
                      posizione: item.struttura?.posizione?.indirizzo,
                    )),
          ),
        )
      ]));

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}

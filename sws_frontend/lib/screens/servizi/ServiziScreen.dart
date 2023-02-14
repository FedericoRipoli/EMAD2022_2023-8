import 'package:flutter/material.dart';
import 'package:frontend_sws/components/filtri/DropDownFilter.dart';
import 'package:frontend_sws/components/servizi/CardServizio.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/ServizioService.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:latlong2/latlong.dart';
import '../../components/filtri/DropDownTextFilter.dart';
import '../../components/filtri/FilterBar.dart';
import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/NoOpsFilter.dart';
import '../../components/filtri/OrderFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomPagedListView.dart';
import '../../services/dto/PuntoMappaDTO.dart';
import '../../theme/theme.dart';
import 'MapTab.dart';

class ServiziScreen extends StatefulWidget {
  bool isFilterOpen = true;
  TextEditingController filtroNomeController = TextEditingController();
  String? idAreaSelected;

  ServiziScreen({Key? key, this.idAreaSelected}) : super(key: key);

  @override
  State<ServiziScreen> createState() => _ServiziScreenState();
}

class _ServiziScreenState extends State<ServiziScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final PagingController<int, Servizio> _pagingController =
      PagingController(firstPageKey: 0);
  ServizioService servizioService = ServizioService();

  EnteService enteService = EnteService();
  List<Ente>? listEnti;
  List<DropDownFilterItem> itemsEnti = [];
  String? dropdownValueEnti;

  AreeService areeService = AreeService();
  List<Area>? listAree;
  List<DropDownFilterItem> itemsAree = [];
  String? dropdownValueArea;

  bool asc = true;
  String orderBy = "nome";
  String orderString = "sort=nome,ASC";

  LatLng centerPosition = LatLng(40.6824408, 14.7680961);

  @override
  void initState() {
    super.initState();
    if(widget.idAreaSelected!=null){
      filterArea=widget.idAreaSelected;
    }
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    tabController = TabController(length: 2, vsync: this);
    initCallMap = loadMapView();
    _determinePosition();
    initAree = loadListAree();
    initAree.then((vAree) {
      initEnti = loadListEnti();
      initEnti.then((vEnti) {
        setState(() {});
      });
    });
  }

  late Future<List<DropDownFilterItem>> initEnti;

  Future<List<DropDownFilterItem>> loadListEnti() async {
    listEnti = await enteService.enteList(
        null, null, "sort=denominazione&denominazione.dir=asc");
    itemsEnti.add(DropDownFilterItem(
      id: "",
      name: "",
    ));
    if (listEnti != null) {
      itemsEnti.addAll(listEnti!.map<DropDownFilterItem>((Ente value) {
        return DropDownFilterItem(
          id: value.id,
          name: value.denominazione,
        );
      }).toList());
    }
    return itemsEnti;
  }

  late Future<List<DropDownFilterItem>> initAree;

  Future<List<DropDownFilterItem>> loadListAree() async {
    listAree = await areeService.areeList(null);
    itemsAree.add(DropDownFilterItem(
      id: "",
      name: "",
    ));
    if (listAree != null) {
      itemsAree.addAll(listAree!.map<DropDownFilterItem>((Area value) {
        return DropDownFilterItem(
          id: value.id,
          name: value.nome,
        );
      }).toList());
    }
    if (widget.idAreaSelected != null) {
      filterArea = dropdownValueArea = widget.idAreaSelected;
      _pullRefresh();
      initCallMap = loadMapView();
      setState(() {});
    }
    return itemsAree;
  }

  String? filterNome;
  String? filterArea;
  String? filterEnte;
  late Future<List<PuntoMappaDto>?> initCallMap;

  Future<List<PuntoMappaDto>?> loadMapView() async {
    ServizioService servizioService = ServizioService();
    return servizioService.findPuntiMappa(filterNome, filterEnte, filterArea);
  }

  void _filterNomeChange(String? text) {
    filterNome = text;
    _pullRefresh();
    initCallMap = loadMapView();
    setState(() {});
  }

  void _filterEnteChange(String? text) {
    filterEnte = text != null && text.isNotEmpty ? text : null;
    _pullRefresh();
    initCallMap = loadMapView();
    setState(() {});
  }

  void _filterAreaChange(String? text) {
    filterArea = text != null && text.isNotEmpty ? text : null;
    _pullRefresh();
    initCallMap = loadMapView();
    setState(() {});
  }

  void _orderChange(String? text) {
    orderString = text ?? orderString;
    _pullRefresh();

    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await servizioService.serviziList(filterNome, filterEnte,
          filterArea, null, pageKey, false, orderString);
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
        brightness: Brightness.dark,
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
          //indicatorPadding: const EdgeInsets.all(0.6),
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.tab,
          border: Border.all(color: appTheme.primaryColor, width: 0.5),
          length: 2,
          tabs: const <Widget>[
            Text("Lista"),
            Text("Mappa"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.isFilterOpen = !widget.isFilterOpen;
                });
              },
              icon: Icon(
                widget.isFilterOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: AppColors.white,
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(widget.isFilterOpen ? 170 : 0),
          child: widget.isFilterOpen
              ? Column(
                  children: [
                    FilterBar(filters: [
                      TextFilter(
                          name: 'Cerca un servizio...',
                          textEditingController: widget.filtroNomeController,
                          positionType: GenericFilterPositionType.row,
                          flex: 9,
                          valueChange: _filterNomeChange),
                      OrderFilter(
                        name: "Ordinamento",
                        flex: 1,
                        elements: {
                          "nome": "Nome",
                          "struttura.ente.denominazione": "Ente",
                        },
                        positionType: GenericFilterPositionType.row,
                        valueChange: _orderChange,
                        orderString: orderString,
                        context: context,
                      ),
                      NoOpsFilter(
                        name: "newline",
                        positionType: GenericFilterPositionType.col,
                        valueChange: (s) {}, //
                      ),
                      DropDownFilter(
                          name: "Seleziona Area",
                          positionType: GenericFilterPositionType.row,
                          valueChange: _filterAreaChange,
                          flex: 4,
                          values: itemsAree,
                          defaultValue: dropdownValueArea),
                      DropDownTextFilter(
                          name: "Seleziona Ente",
                          positionType: GenericFilterPositionType.row,
                          flex: 4,
                          valueChange: _filterEnteChange, //TODO
                          values: itemsEnti),
                    ]),
                  ],
                )
              : Container(),
        ),
      ),
      body: GFTabBarView(controller: tabController, children: <Widget>[
        searchList,
        MapTab(
          initCallMap: initCallMap,
          centerPos: centerPosition,
        )
      ]),
    );
  }

  late Widget searchList = RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Column(children: <Widget>[
        Flexible(
          child: CustomPagedListView<Servizio>(
              pagingController: _pagingController,
              itemBuilder: (context, item, index) => CardServizio(
                    idServizio: item.id!,
                    nomeServizio: item.nome,
                    ente: item.struttura!.ente!.denominazione,
                    aree: item.aree!,
                    posizione: item.struttura?.posizione?.indirizzo,
                  )),
        ),
      ]));

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  void _determinePosition() async {
    bool serviceEnabled;
    gl.LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == gl.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    gl.Position currentPosition = await gl.Geolocator.getCurrentPosition(
        desiredAccuracy: gl.LocationAccuracy.bestForNavigation);
    centerPosition =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    setState(() {});
  }
}

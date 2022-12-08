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
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/filtri/FilterBar.dart';
import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
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

  EnteService enteService = EnteService();
  List<Ente>? listEnti;
  List<DropDownFilterItem> itemsEnti = [];
  String? dropdownValueEnti;

  AreeService areeService = AreeService();
  List<Area>? listAree;
  List<DropDownFilterItem> itemsAree = [];
  String? dropdownValueArea;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    tabController = TabController(length: 2, vsync: this);
    initCallMap = loadMapView();
    initAree = loadListAree();
    initEnti = loadListEnti();
  }

  late Future<List<DropDownFilterItem>> initEnti;
  Future<List<DropDownFilterItem>> loadListEnti() async{
    listEnti = await enteService.enteList(null,null);
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
      dropdownValueEnti = listEnti!.first.id;
    }
    return itemsEnti;
  }

  late Future<List<DropDownFilterItem>> initAree;
  Future<List<DropDownFilterItem>> loadListAree() async{
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
      dropdownValueArea = listAree!.first.id;
    }
    return itemsAree;
  }

  String? filterNome;
  late Future<List<PuntoMappaDto>?> initCallMap;
  Future<List<PuntoMappaDto>?> loadMapView() async {
    ServizioService servizioService = ServizioService();
    return servizioService.findPuntiMappa(filterNome);
  }

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
              icon: const Icon(
                Icons.search,
                color: AppColors.white,
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(widget.isFilterOpen ? 150 : 0),
          child: widget.isFilterOpen
              ? Container(
                child: Column(
                  children: [
                    FilterBar(
                        filters: [
                          TextFilter(
                              name: 'Cerca un servizio...',
                              textEditingController: widget.filtroNomeController,
                              positionType: GenericFilterPositionType.col,
                              valueChange: _filterNomeChange
                          ),
                          DropDownFilter(
                              name: "Seleziona Area",
                              positionType: GenericFilterPositionType.row,
                              valueChange: _filterNomeChange,//TODO
                              values: itemsAree
                          ),
                          DropDownFilter(
                              name: "Seleziona Ente",
                              positionType: GenericFilterPositionType.row,
                              valueChange: _filterNomeChange,//TODO
                              values: itemsEnti
                          )
                        ]
                    ),
                  ],
                ),
              )
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

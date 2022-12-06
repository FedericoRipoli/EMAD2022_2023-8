import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/components/aree/HorizontalListAree.dart';
import 'package:frontend_sws/components/eventi/CardEvento.dart';
import 'package:frontend_sws/components/servizi/CardServizio.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../components/aree/DropdownAree.dart';
import '../theme/theme.dart';

class SearchScreen extends StatefulWidget {
  final bool isServizi;
  bool isFilterOpen = false;

  SearchScreen({Key? key, required this.isServizi}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: GFAppBar(
        backgroundColor: AppColors.logoBlue,
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
              ? Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 3, bottom: 3),
                  color: AppColors.logoBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 320,
                        height: 40,
                        child: TextField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 16, color: Colors.white),
                                labelText: 'Cerca un servizio',
                                fillColor: Colors.white,
                                floatingLabelStyle:
                                    TextStyle(color: Colors.white))),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const DropdownAree()
                    ],
                  ),
                )
              : Container(),
        ),
      ),
      body: GFTabBarView(controller: tabController, children: <Widget>[
        searchList,
        searchMap,
      ]),
    );
  }

  Widget searchMap = Container(
    child: FlutterMap(
      options: MapOptions(
        center: LatLng(40.6824408, 14.7680961),
        zoom: 15.0,
        maxZoom: 30.0,
        enableScrollWheel: true,
        scrollWheelVelocity: 0.005,
      ),
      children: [
        TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
        MarkerLayer(
          markers: [
            Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(40.6824408, 14.7680961),
                builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: AppColors.logoBlue,
                      size: 50,
                    ))
          ],
        )
      ],
    ),
  );

  late Widget searchList = SingleChildScrollView(
    child: widget.isServizi
        ? Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 18, bottom: 18),
                    child: Text(
                      "Risultati Ricerca:",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.logoCadmiumOrange),
                    ),
                  ),
                ],
              ),
              !isEmptyList
                  ? ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(12),
                      itemCount: listServices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listServices[index];
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: AppColors.white,
                        thickness: 0.0,
                      ),
                    )
                  : const Center(
                      child: Text(
                        "Nessun Risultato :(",
                        style:
                            TextStyle(fontSize: 18, fontFamily: "FredokaOne"),
                      ),
                    ),
            ],
          )
        : Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 18, bottom: 18),
                    child: Text(
                      "Eventi più recenti in programma:",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.logoCadmiumOrange),
                    ),
                  ),
                ],
              ),
              !isEmptyList
                  ? ListView.separated(
                      //physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      itemCount: listEventi.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GridView.count(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          children: List.generate(2, (index) {
                            return listEventi[index];
                          }),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: AppColors.white,
                        thickness: 0.0,
                      ),
                    )
                  : const Center(
                      child: Text(
                        "Nessun Risultato :(",
                        style:
                            TextStyle(fontSize: 22, fontFamily: "FredokaOne"),
                      ),
                    ),
            ],
          ),
  );
}

List<CardServizio> listServices = [
  const CardServizio(
    title: "title",
    ente: "subtitle",
    area: "ambito",
  ),
  const CardServizio(
    title: "title",
    ente: "subtitle",
    area: "ambito",
  ),
];

List<CardEvento> listEventi = [
  CardEvento(
    luogo: '20:00',
    data: '22 Dicembre',
    imgPath: 'images/volantino.jpg',
    nome: 'Luci di Salerno',
  ),
  CardEvento(
    luogo: '20:00',
    data: '22 Dicembre',
    imgPath: 'images/volantino.jpg',
    nome: 'Luci di Salerno',
  ),
  CardEvento(
    luogo: '20:00',
    data: '22 Dicembre',
    imgPath: 'images/volantino.jpg',
    nome: 'Luci di Salerno',
  ),
  CardEvento(
    luogo: '20:00',
    data: '22 Dicembre',
    imgPath: 'images/volantino.jpg',
    nome: 'Luci di Salerno',
  ),
];

bool isEmptyList = false;

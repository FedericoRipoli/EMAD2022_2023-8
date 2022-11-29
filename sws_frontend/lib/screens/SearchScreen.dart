import 'package:flutter/material.dart';
import 'package:frontend_sws/components/CardServizio.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/theme.dart';

class SearchScreen extends StatefulWidget {
  final bool typeSearch; // true=servizi, false=eventi
  const SearchScreen({Key? key, required this.typeSearch}) : super(key: key);

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
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          automaticallyImplyLeading: true,
          title: GFSegmentTabs(
            height: 38,
            tabController: tabController,
            tabBarColor: appTheme.primaryColor,
            labelColor: appTheme.primaryColor,
            labelPadding: const EdgeInsets.all(8),
            labelStyle: const TextStyle(fontSize: 18, fontFamily: "FredokaOne"),
            unselectedLabelStyle:
                const TextStyle(fontSize: 16, fontFamily: "FredokaOne"),
            unselectedLabelColor: GFColors.WHITE,
            indicator: const BoxDecoration(
              color: GFColors.WHITE,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            indicatorPadding: const EdgeInsets.all(0.6),
            indicatorWeight: 4,
            indicatorSize: TabBarIndicatorSize.tab,
            border: Border.all(color: appTheme.primaryColor, width: 0.5),
            length: 2,
            tabs: const <Widget>[
              Text(
                "MAPPA",
              ),
              Text(
                "LISTA",
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.filter_list_outlined))
          ],
        ),
      ),
      body: GFTabBarView(
          controller: tabController, children: <Widget>[searchMap, searchList]),
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
                builder: (ctx) => Container(
                        child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    )))
          ],
        )
      ],
    ),
  );
  Widget searchList = SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 18, bottom: 18),
              child: Text(
                "Filtra per:",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          itemCount: listServices.length,
          itemBuilder: (BuildContext context, int index) {
            return listServices[index];
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ],
    ),
  );
}

List<CardServizio> listServices = [
  const CardServizio(
      title: "title",
      subtitle: "subtitle",
      ambito: "ambito",
      tipologia: "type",
      tags: "tags"),
  const CardServizio(
      title: "title",
      subtitle: "subtitle",
      ambito: "ambito",
      tipologia: "type",
      tags: "tags"),
  const CardServizio(
      title: "title",
      subtitle: "subtitle",
      ambito: "ambito",
      tipologia: "type",
      tags: "tags"),
  const CardServizio(
      title: "title",
      subtitle: "subtitle",
      ambito: "ambito",
      tipologia: "type",
      tags: "tags"),
];

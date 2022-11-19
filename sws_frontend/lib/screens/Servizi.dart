import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Servizi extends StatefulWidget {
  const Servizi({Key? key}) : super(key: key);

  @override
  _ServiziState createState() => _ServiziState();
}

class _ServiziState extends State<Servizi> with TickerProviderStateMixin {
  late TabController tabController;
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

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: GFAppBar(
          backgroundColor: appTheme.primaryColor,
          searchBar: true,
          searchHintText: "Cerca...",
          searchHintStyle: const TextStyle(fontSize: 16, color: Colors.white),
          searchTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
          searchBarColorTheme: GFColors.WHITE,
          leading: const Icon(Icons.map),
          automaticallyImplyLeading: true,
          title: GFSegmentTabs(
            tabController: tabController,
            tabBarColor: appTheme.primaryColor,
            labelColor: appTheme.primaryColor,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelColor: GFColors.WHITE,
            indicator: const BoxDecoration(
              color: GFColors.WHITE,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            indicatorPadding: const EdgeInsets.all(3.0),
            indicatorWeight: 1.0,
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
        ),
      ),
      body: GFTabBarView(controller: tabController, children: <Widget>[
        Container(
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
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
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
        ),
        SingleChildScrollView(
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
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return GFListTile(
                      titleText: 'Elemento ${entries[index]}',
                      color: Color(0xffD3D3D3),
                      description: const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing'),
                      subTitleText:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing',
                      icon: const Icon(Icons.location_on));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

/*


*/

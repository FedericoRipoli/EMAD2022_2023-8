import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPicker extends StatefulWidget {
  MapPicker({Key? key}) : super(key: key);

  @override
  _MapPicker createState() {
    return _MapPicker();
  }
}

class _MapPicker extends State<MapPicker> {
  double defaultLat = 40.6824408, defaultLong = 14.7680961;
  late Marker _locationMarker;
  Location location = Location();
  //late LocationData _currentPosition;

  @override
  void initState() {
    super.initState();
    //_getUserLocation();
    _locationMarker = Marker(
        point: LatLng(defaultLat, defaultLong),
        builder: (ctx) => const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 32,
            ));
  }

  // get user current location
  /*
  _getUserLocation() async {
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    // Check if permission is granted
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
      });
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 250,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(defaultLat, defaultLong),
            zoom: 15.0,
            maxZoom: 30.0,
            enableScrollWheel: true,
            scrollWheelVelocity: 0.005,
            onTap: (tapPosition, point) => {
              print(point.toString()),
              // salvare la posizione qui
              setState(() {
                _locationMarker = Marker(
                    point: point,
                    builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 32,
                        ));
              })
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const <String>['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                _locationMarker,
              ],
            ),
          ],
        ));
  }
}

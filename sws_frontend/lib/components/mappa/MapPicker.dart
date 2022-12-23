import 'package:geolocator/geolocator.dart' as gl;
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../loading/AllPageLoad.dart';

class MapPicker extends StatefulWidget {
  final ValueChanged<LatLng?> mapValueChanged;
  const MapPicker({Key? key,required this.mapValueChanged}) : super(key: key);

  @override
  _MapPicker createState() {
    return _MapPicker();
  }
}

class _MapPicker extends State<MapPicker> {
  late Marker _locationMarker;
  LatLng centerPosition=LatLng(40.6824408, 14.7680961);
  bool loaded=false;





  /// Determine the current position of the device.
  ///
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
    gl.Position currentPosition = await  gl.Geolocator.getCurrentPosition(desiredAccuracy: gl.LocationAccuracy.bestForNavigation);
    centerPosition=LatLng(currentPosition.latitude, currentPosition.longitude);
    _locationMarker = Marker(
        point: centerPosition,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 32,
        ));
    widget.mapValueChanged!(centerPosition);

    loaded=true;

    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    _determinePosition();
    widget.mapValueChanged!(centerPosition);

  }

  // get user current location



  @override
  Widget build(BuildContext context) {
    return !loaded?
    const AllPageLoad()
    : SizedBox(
        height: 250,
        child: FlutterMap(
          options: MapOptions(
            center: centerPosition,
            zoom: 15.0,
            maxZoom: 30.0,
            enableScrollWheel: true,
            scrollWheelVelocity: 0.005,
            onTap: (tapPosition, point)  {
              // salvare la posizione qui
              setState(() {
                _locationMarker = Marker(
                    point: point,
                    builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 32,
                        ));
              });
              widget.mapValueChanged!(point);
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

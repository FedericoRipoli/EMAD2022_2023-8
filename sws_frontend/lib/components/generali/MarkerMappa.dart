import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../theme/theme.dart';

class MarkerMappa{
  String latLong;

  MarkerMappa(this.latLong);

  Marker getMarker(){
    List<String> ll=latLong.split(", ");
    return Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(double.parse(ll[0]),double.parse(ll[1])),
        builder: (ctx) => const IconButton(
          onPressed: null,
          icon:  Icon(Icons.location_on, size: 50,color: AppColors.logoBlue,),

          


        ),
    );
  }
}
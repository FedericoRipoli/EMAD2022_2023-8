import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../services/dto/PuntoMappaDTO.dart';
import '../../theme/theme.dart';

class MarkerMappa extends Marker {
  PuntoMappaDto punto;

  MarkerMappa(this.punto)
      : super(
          point: LatLng(double.parse(punto.posizione.split(", ")[0]),
              double.parse(punto.posizione.split(", ")[1])),
          builder: (ctx) => const Icon(
            Icons.location_on,
            size: 50,
            color: AppColors.logoBlue,
          ),
          width: 30.0,
          height: 30.0,
        );
}

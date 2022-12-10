import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../services/dto/PuntoMappaDTO.dart';
import '../../theme/theme.dart';

class MarkerMappa extends Marker {
  PuntoMappaDto punto;
  bool? isSelected;

  MarkerMappa({required this.punto, this.isSelected})
      : super(
          point: LatLng(double.parse(punto.posizione.split(", ")[0]),
              double.parse(punto.posizione.split(", ")[1])),
          builder: (ctx) => Icon(
            punto.customIcon==null ?Icons.location_on : punto.getIconData()!,
            size: 50,
            color: isSelected!=null && isSelected! ? AppColors.logoCadmiumOrange:AppColors.logoBlue,
          ),
          width: 30.0,
          height: 30.0,
        );

}

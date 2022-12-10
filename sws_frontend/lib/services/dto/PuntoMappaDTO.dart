import 'dart:convert';

// To parse this JSON data, do
//
//     final puntoMappaDto = puntoMappaDtoFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'ServizioMappaDTO.dart';

PuntoMappaDto puntoMappaDtoFromJson(String str) => PuntoMappaDto.fromJson(json.decode(str));

String puntoMappaDtoToJson(PuntoMappaDto data) => json.encode(data.toJson());

class PuntoMappaDto {
  PuntoMappaDto({
    required this.posizione,
    required this.punti,
    this.customIcon
  });

  String posizione;
  List<ServizioMappaDto> punti;
  String? customIcon;

  factory PuntoMappaDto.fromJson(Map<String, dynamic> json) => PuntoMappaDto(
    posizione: json["posizione"],
    customIcon: json["customIcon"],
    punti: List<ServizioMappaDto>.from(json["punti"].map((x) => ServizioMappaDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "posizione": posizione,
    "customIcon": customIcon,
    "punti": List<dynamic>.from(punti.map((x) => x.toJson())),
  };
  IconData? getIconData(){

    return customIcon!=null?IconData(int.parse(customIcon!),fontFamily: "MaterialIcons"):null;
  }
}


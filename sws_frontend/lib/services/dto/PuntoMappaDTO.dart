import 'dart:convert';

// To parse this JSON data, do
//
//     final puntoMappaDto = puntoMappaDtoFromJson(jsonString);

import 'dart:convert';

import 'ServizioMappaDTO.dart';

PuntoMappaDto puntoMappaDtoFromJson(String str) => PuntoMappaDto.fromJson(json.decode(str));

String puntoMappaDtoToJson(PuntoMappaDto data) => json.encode(data.toJson());

class PuntoMappaDto {
  PuntoMappaDto({
    required this.posizione,
    required this.punti,
  });

  String posizione;
  List<ServizioMappaDto> punti;

  factory PuntoMappaDto.fromJson(Map<String, dynamic> json) => PuntoMappaDto(
    posizione: json["posizione"],
    punti: List<ServizioMappaDto>.from(json["punti"].map((x) => ServizioMappaDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "posizione": posizione,
    "punti": List<dynamic>.from(punti.map((x) => x.toJson())),
  };
}


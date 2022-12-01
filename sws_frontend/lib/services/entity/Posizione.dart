// To parse this JSON data, do
//
//     final posizione = posizioneFromJson(jsonString);

import 'dart:convert';

Posizione posizioneFromJson(String str) => Posizione.fromJson(json.decode(str));

String posizioneToJson(Posizione data) => json.encode(data.toJson());

class Posizione {
  Posizione({
    this.id,
    this.indirizzo,
    this.latitudine,
    this.longitudine,
  });

  String? id;
  String? indirizzo;
  String? latitudine;
  String? longitudine;

  factory Posizione.fromJson(Map<String, dynamic> json) => Posizione(
    id: json["id"],
    indirizzo: json["indirizzo"],
    latitudine: json["latitudine"],
    longitudine: json["longitudine"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "indirizzo": indirizzo,
    "latitudine": latitudine,
    "longitudine": longitudine,
  };
}

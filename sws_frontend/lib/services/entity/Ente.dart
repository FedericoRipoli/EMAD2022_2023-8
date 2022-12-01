// To parse this JSON data, do
//
//     final ente = enteFromJson(jsonString);

import 'dart:convert';
import './Contatto.dart';
import './ImageData.dart';
import 'Struttura.dart';
Ente enteFromJson(String str) => Ente.fromJson(json.decode(str));

String enteToJson(Ente data) => json.encode(data.toJson());

class Ente {
  Ente({
    this.id,
    required this.denominazione,
    this.descrizione,
    this.strutture
  });

  String? id;
  String denominazione;
  String? descrizione;
  List<Struttura>? strutture;

  factory Ente.fromJson(Map<String, dynamic> json) => Ente(
    id: json["id"],
    denominazione: json["denominazione"],
    descrizione: json["descrizione"],
    strutture: json["strutture"]!=null?List<Struttura>.from(json["strutture"].map((x) => Struttura.fromJson(x))):null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "denominazione": denominazione,
    "descrizione": descrizione,
    "strutture": strutture?.map((x) => x).toList(),
  };
}
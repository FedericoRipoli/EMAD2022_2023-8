import 'dart:convert';

import 'Posizione.dart';

Struttura strutturaFromJson(String str) => Struttura.fromJson(json.decode(str));

String strutturaToJson(Struttura data) => json.encode(data.toJson());

class Struttura {
  Struttura({
    this.id,
    this.denominazione,
    this.posizione,
  });

  String? id;
  String? denominazione;
  Posizione? posizione;

  factory Struttura.fromJson(Map<String, dynamic> json) => Struttura(
    id: json["id"],
    denominazione: json["denominazione"],
    posizione: Posizione.fromJson(json["posizione"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "denominazione": denominazione,
    "posizione": posizione?.toJson()
  };
}
import 'dart:convert';

import 'Ente.dart';
import 'Posizione.dart';

Struttura strutturaFromJson(String str) => Struttura.fromJson(json.decode(str));

String strutturaToJson(Struttura data) => json.encode(data.toJson());

class Struttura {
  Struttura({this.id, this.denominazione, this.posizione, this.ente});

  String? id;
  String? denominazione;
  Posizione? posizione;
  Ente? ente;

  factory Struttura.fromJson(Map<String, dynamic> json) => Struttura(
        id: json["id"],
        denominazione: json["denominazione"],
        posizione: json["posizione"] == null
            ? null
            : Posizione.fromJson(json["posizione"]),
        ente: json["ente"] == null ? null : Ente.fromJson(json["ente"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "denominazione": denominazione,
        "posizione": posizione?.toJson(),
        "ente": ente?.toJson()
      };
}

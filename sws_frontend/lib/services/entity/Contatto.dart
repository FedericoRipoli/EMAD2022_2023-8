// To parse this JSON data, do
//
//     final contatto = contattoFromJson(jsonString);

import 'dart:convert';

Contatto contattoFromJson(String str) => Contatto.fromJson(json.decode(str));

String contattoToJson(Contatto data) => json.encode(data.toJson());

class Contatto {
  Contatto({
    required this.denominazione,
    this.email,
    this.cellulare,
    this.telefono,
    this.pec,
    this.sitoWeb,
    this.ente,
  });

  String denominazione;
  String? email;
  String? cellulare;
  String? telefono;
  String? pec;
  String? sitoWeb;
  String? ente;

  factory Contatto.fromJson(Map<String, dynamic> json) => Contatto(
    denominazione: json["denominazione"],
    email: json["email"],
    cellulare: json["cellulare"],
    telefono: json["telefono"],
    pec: json["pec"],
    sitoWeb: json["sitoWeb"],
    ente: json["ente"],
  );

  Map<String, dynamic> toJson() => {
    "denominazione": denominazione,
    "email": email,
    "cellulare": cellulare,
    "telefono": telefono,
    "pec": pec,
    "sitoWeb": sitoWeb,
    "ente": ente,
  };
}

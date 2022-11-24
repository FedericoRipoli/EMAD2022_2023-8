// To parse this JSON data, do
//
//     final contatto = contattoFromJson(jsonString);

import 'dart:convert';

Contatto contattoFromJson(String str) => Contatto.fromJson(json.decode(str));

String contattoToJson(Contatto data) => json.encode(data.toJson());

class Contatto {
  Contatto({
    this.id,
    required this.denominazione,
    this.email,
    this.cellulare,
    this.telefono,
    this.pec,
    this.sitoWeb,
    this.ente,
  });

  String? id;
  String denominazione;
  String? email;
  String? cellulare;
  String? telefono;
  String? pec;
  String? sitoWeb;
  String? ente;

  factory Contatto.fromJson(Map<String, dynamic> json) => Contatto(
    id: json["id"],
    denominazione: json["denominazione"],
    email: json["email"],
    cellulare: json["cellulare"],
    telefono: json["telefono"],
    pec: json["pec"],
    sitoWeb: json["sitoWeb"],
    ente: json["ente"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "denominazione": denominazione,
    "email": email,
    "cellulare": cellulare,
    "telefono": telefono,
    "pec": pec,
    "sitoWeb": sitoWeb,
    "ente": ente,
  };
}

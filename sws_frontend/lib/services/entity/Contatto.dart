// To parse this JSON data, do
//
//     final contatto = contattoFromJson(jsonString);

import 'dart:convert';

Contatto contattoFromJson(String str) => Contatto.fromJson(json.decode(str));

String contattoToJson(Contatto data) => json.encode(data.toJson());

class Contatto {
  Contatto({
    this.id,
    this.denominazione,
    this.email,
    this.telefono,
    this.sitoWeb,
  });

  String? id;
  String? denominazione;
  String? email;
  String? telefono;
  String? sitoWeb;

  factory Contatto.fromJson(Map<String, dynamic> json) => Contatto(
    id: json["id"],
    denominazione: json["denominazione"],
    email: json["email"],
    telefono: json["telefono"],
    sitoWeb: json["sitoWeb"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "denominazione": denominazione,
    "email": email,
    "telefono": telefono,
    "sitoWeb": sitoWeb,
  };
}

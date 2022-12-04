// To parse this JSON data, do
//
//     final contatto = contattoFromJson(jsonString);

import 'dart:convert';

Contatto contattoFromJson(String str) => Contatto.fromJson(json.decode(str));

String contattoToJson(Contatto data) => json.encode(data.toJson());

class Contatto {
  Contatto({
    this.id,
    this.email,
    this.telefono,
    this.sitoWeb,
  });

  String? id;
  String? email;
  String? telefono;
  String? sitoWeb;

  factory Contatto.fromJson(Map<String, dynamic> json) => Contatto(
    id: json["id"],
    email: json["email"],
    telefono: json["telefono"],
    sitoWeb: json["sitoWeb"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "email": email,
    "telefono": telefono,
    "sitoWeb": sitoWeb,
  };
}

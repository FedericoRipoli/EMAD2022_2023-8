// To parse this JSON data, do
//
//     final ente = enteFromJson(jsonString);

import 'dart:convert';
import './Contatto.dart';
import './ImageData.dart';
Ente enteFromJson(String str) => Ente.fromJson(json.decode(str));

String enteToJson(Ente data) => json.encode(data.toJson());

class Ente {
  Ente({
    this.id,
    required this.denominazione,
    this.descrizione,
    this.piva,
    this.cf,
    this.contatto,
    this.logo,
    this.immagini,
    this.contatti,
  });

  String? id;
  String denominazione;
  String? descrizione;
  String? piva;
  String? cf;
  Contatto? contatto;
  ImageData? logo;
  List<ImageData>? immagini;
  List<Contatto>? contatti;

  factory Ente.fromJson(Map<String, dynamic> json) => Ente(
    id: json["id"],
    denominazione: json["denominazione"],
    descrizione: json["descrizione"],
    piva: json["piva"],
    cf: json["cf"],
    contatto: json["contatto"]!=null?Contatto.fromJson(json["contatto"]):null,
    logo: json["logo"]!=null?ImageData.fromJson(json["logo"]):null,
    immagini: json["immagini"]!=null?List<ImageData>.from(json["immagini"].map((x) => ImageData.fromJson(x))):null,
    contatti: json["contatti"]!=null?List<Contatto>.from(json["contatti"].map((x) => Contatto.fromJson(x))):null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "denominazione": denominazione,
    "descrizione": descrizione,
    "piva": piva,
    "cf": cf,
    "contatto": contatto?.toJson(),
    "logo": logo?.toJson(),
    "immagini":  immagini?.map((x) => x).toList(),
    "contatti": contatti?.map((x) => x).toList(),
  };
}
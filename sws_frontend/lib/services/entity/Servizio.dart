// To parse this JSON data, do
//
//     final servizio = servizioFromJson(jsonString);

import 'dart:convert';

import 'Area.dart';
import 'Struttura.dart';

Servizio servizioFromJson(String str) => Servizio.fromJson(json.decode(str));

String servizioToJson(Servizio data) => json.encode(data.toJson());

class Servizio {
  Servizio({
    this.id,
    required this.nome,
    this.contenuto,
    this.stato,
    this.note,
    this.dataCreazione,
    this.dataUltimaModifica,
    this.hashtag,
    this.aree,
    this.struttura,
  });

  String? id;
  String nome;
  String? contenuto;
  String? stato;
  String? note;
  String? dataCreazione;
  String? dataUltimaModifica;
  List<String>? hashtag;
  List<Area>? aree;
  Struttura? struttura;

  factory Servizio.fromJson(Map<String, dynamic> json) => Servizio(
    id: json["id"],
    nome: json["nome"],
    contenuto: json["contenuto"],
    stato: json["stato"],
    note: json["note"],
    dataCreazione: json["dataCreazione"],
    dataUltimaModifica: json["dataUltimaModifica"],
    hashtag: json["hashtag"] !=null ? List<String>.from(json["hashtag"].map((x) => x)):null,
    aree: json["aree"] !=null ? List<Area>.from(json["aree"].map((x) => Area.fromJson(x))):null,
    struttura: json["struttura"] !=null ? Struttura.fromJson(json["struttura"]):null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "contenuto": contenuto,
    "stato": stato,
    "note": note,
    "dataCreazione": dataCreazione,
    "dataUltimaModifica": dataUltimaModifica,
    "hashtag": hashtag !=null ? List<dynamic>.from(hashtag!.map((x) => x)):null,
    "aree": aree !=null ? List<dynamic>.from(aree!.map((x) => x.toJson())):null,
    "struttura": struttura !=null ? struttura!.toJson():null,
  };
}
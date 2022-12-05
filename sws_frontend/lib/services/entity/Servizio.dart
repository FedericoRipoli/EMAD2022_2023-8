// To parse this JSON data, do
//
//     final servizio = servizioFromJson(jsonString);

import 'dart:convert';

import 'Area.dart';
import 'Contatto.dart';
import 'Struttura.dart';

Servizio servizioFromJson(String str) => Servizio.fromJson(json.decode(str));

String servizioToJson(Servizio data) => json.encode(data.toJson());

class Servizio {
  static const String DA_APPROVARE = "DA_APPROVARE";
  static const String APPROVATO = "APPROVATO";
  static const String IN_MODIFICA = "IN_MODIFICA";
  static const String ANNULLATO = "ANNULLATO";
  static const String DA_CANCELLARE = "DA_CANCELLARE";

  static bool canEnteEdit(String? stato) {
    return stato==null || stato == APPROVATO || stato == IN_MODIFICA;
  }

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
    this.contatto,
    this.idStruttura,
    this.idAree,
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
  Contatto? contatto;
  String? idStruttura;
  List<String>? idAree;

  factory Servizio.fromJson(Map<String, dynamic> json) =>
      Servizio(
        id: json["id"],
        nome: json["nome"],
        contenuto: json["contenuto"],
        stato: json["stato"],
        note: json["note"],
        dataCreazione: json["dataCreazione"],
        dataUltimaModifica: json["dataUltimaModifica"],
        hashtag: json["hashtag"] != null ? List<String>.from(
            json["hashtag"].map((x) => x)) : null,
        aree: json["aree"] != null ? List<Area>.from(
            json["aree"].map((x) => Area.fromJson(x))) : null,
        struttura: json["struttura"] != null ? Struttura.fromJson(
            json["struttura"]) : null,
        contatto: json["contatto"] != null
            ? Contatto.fromJson(json["contatto"])
            : null,
        idStruttura: json["idStruttura"],
        idAree: json["idAree"] != null ? jsonDecode(json["idAree"]) : null,
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "nome": nome,
        "contenuto": contenuto,
        "stato": stato,
        "note": note,
        "dataCreazione": dataCreazione,
        "dataUltimaModifica": dataUltimaModifica,
        "hashtag": hashtag != null
            ? List<dynamic>.from(hashtag!.map((x) => x))
            : null,
        "aree": aree != null
            ? List<dynamic>.from(aree!.map((x) => x.toJson()))
            : null,
        "struttura": struttura != null ? struttura!.toJson() : null,
        "contatto": contatto != null ? contatto!.toJson() : null,
        "idStruttura": idStruttura,
        "idAree": idAree,
      };
}
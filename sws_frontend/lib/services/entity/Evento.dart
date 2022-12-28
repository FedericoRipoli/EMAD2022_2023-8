import 'dart:convert';
import 'ImageData.dart';
import 'Contatto.dart';
import 'Area.dart';
import 'Posizione.dart';

Evento eventoFromJson(String str) => Evento.fromJson(json.decode(str));

String eventoToJson(Evento data) => json.encode(data.toJson());

class Evento {
  static const String DA_APPROVARE = "DA_APPROVARE";
  static const String APPROVATO = "APPROVATO";
  static const String IN_MODIFICA = "IN_MODIFICA";
  static const String DA_CANCELLARE = "DA_CANCELLARE";

  static Map<String, String> getStatiList() {
    Map<String, String> toRet = {
      DA_APPROVARE: "Da approvare",
      APPROVATO: "Approvato",
      IN_MODIFICA: "In modifica",
      DA_CANCELLARE: "Da cancellare",
    };
    return toRet;
  }

  static bool canEnteEdit(String? stato) {
    return stato == null || stato == APPROVATO || stato == IN_MODIFICA;
  }

  String? id;
  String nome;
  String? contenuto;
  String? stato;
  String? note;
  String? dataCreazione;
  String? dataUltimaModifica;
  String? dataInizio;
  String? dataFine;
  List<String>? hashtags;
  List<Area>? aree;
  Contatto? contatto;
  List<String>? idAree;
  ImageData? locandina;
  Posizione? posizione;

  Evento(
      {this.id,
      required this.nome,
      this.contenuto,
      this.stato,
      this.note,
      this.dataCreazione,
      this.dataUltimaModifica,
      this.dataInizio,
      this.dataFine,
      this.hashtags,
      this.aree,
      this.contatto,
      this.idAree,
      this.locandina,
      this.posizione});

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        id: json["id"],
        nome: json["nome"],
        contenuto: json["contenuto"],
        stato: json["stato"],
        note: json["note"],
        dataCreazione: json["dataCreazione"],
        dataUltimaModifica: json["dataUltimaModifica"],
        dataInizio: json["dataInizio"],
        dataFine: json["dataFine"],
        hashtags: json["hashtags"] != null
            ? List<String>.from(json["hashtags"].map((x) => x))
            : null,
        aree: json["aree"] != null
            ? List<Area>.from(json["aree"].map((x) => Area.fromJson(x)))
            : null,
        contatto: json["contatto"] != null
            ? Contatto.fromJson(json["contatto"])
            : null,
        idAree: json["idAree"] != null ? jsonDecode(json["idAree"]) : null,
        locandina: json["locandina"] != null
            ? ImageData.fromJson(json["locandina"])
            : null,
        posizione: json["posizione"] == null
            ? null
            : Posizione.fromJson(json["posizione"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "contenuto": contenuto,
        "stato": stato,
        "note": note,
        "dataCreazione": dataCreazione,
        "dataUltimaModifica": dataUltimaModifica,
        "dataInizio": dataInizio,
        "dataFine": dataFine,
        "hashtags": hashtags != null
            ? List<dynamic>.from(hashtags!.map((x) => x))
            : null,
        "aree": aree != null
            ? List<dynamic>.from(aree!.map((x) => x.toJson()))
            : null,
        "contatto": contatto != null ? contatto!.toJson() : null,
        "idAree": idAree,
        "locandina": locandina != null ? locandina!.toJson() : null,
        "posizione": posizione != null ? posizione!.toJson() : null,
      };
}

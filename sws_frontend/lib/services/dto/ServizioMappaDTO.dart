// To parse this JSON data, do
//
//     final servizioMappaDto = servizioMappaDtoFromJson(jsonString);

import 'dart:convert';

ServizioMappaDto servizioMappaDtoFromJson(String str) => ServizioMappaDto.fromJson(json.decode(str));

String servizioMappaDtoToJson(ServizioMappaDto data) => json.encode(data.toJson());

class ServizioMappaDto {
  ServizioMappaDto({
    required this.id,
    required this.nome,
    required this.struttura,
    required this.indirizzo,
    required this.ente,
    this.posizione,
  });

  String id;
  String nome;
  String struttura;
  String ente;
  String indirizzo;
  String? posizione;

  factory ServizioMappaDto.fromJson(Map<String, dynamic> json) => ServizioMappaDto(
    id: json["id"],
    nome: json["nome"],
    struttura: json["struttura"],
    ente: json["ente"],
    posizione: json["posizione"],
    indirizzo: json["indirizzo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "struttura": struttura,
    "ente": ente,
    "posizione": posizione,
    "indirizzo": indirizzo,
  };
}

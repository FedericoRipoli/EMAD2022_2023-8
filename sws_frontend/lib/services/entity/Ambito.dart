// To parse this JSON data, do
//
//     final ambito = ambitoFromJson(jsonString);

import 'dart:convert';

Ambito ambitoFromJson(String str) => Ambito.fromJson(json.decode(str));

String ambitoToJson(Ambito data) => json.encode(data.toJson());

class Ambito {
  Ambito({
    this.id,
    required this.nome,
    this.figli,
    this.padre,
  });

  String? id;
  String nome;
  List<Ambito>? figli;
  Ambito? padre;

  factory Ambito.fromJson(Map<String, dynamic> json) => Ambito(
    id: json["id"],
    nome: json["nome"],
    figli: json["figli"]!=null? List<Ambito>.from(json["figli"].map((x) => ambitoFromJson(x))):null,
    padre:json["padre"]!=null? ambitoFromJson(json["padre"]):null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "figli": figli!=null?List<Ambito>.from(figli!.map((x) => ambitoToJson(x))):null,
    "padre": padre!=null?ambitoToJson(padre!):null,
  };
}

class Padre {
  Padre();

  factory Padre.fromJson(Map<String, dynamic> json) => Padre(
  );

  Map<String, dynamic> toJson() => {
  };
}

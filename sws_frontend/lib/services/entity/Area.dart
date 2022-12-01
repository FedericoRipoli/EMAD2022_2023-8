// To parse this JSON data, do
//
//     final area = areaFromJson(jsonString);

import 'dart:convert';

Area areaFromJson(String str) => Area.fromJson(json.decode(str));

String areaToJson(Area data) => json.encode(data.toJson());

class Area {
  Area({
    this.id,
    required this.nome,
  });

  String? id;
  String nome;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"],
    nome: json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
  };
}

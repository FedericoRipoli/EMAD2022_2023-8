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
  });

  String? id;
  String nome;
  List<Ambito>? figli;


  factory Ambito.fromJson(Map<String, dynamic> json) {

    String id=json["id"];
    String nome=json["nome"];
    List<Ambito> figli=[];
    if(json["figli"]!=null){
      for(var a in json["figli"]){
        Ambito f=Ambito.fromJson(a);
        figli.add(f);
      }
    }
    return Ambito(nome: nome, figli:figli,id:id);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "figli": figli!=null?List<Ambito>.from(figli!.map((x) => ambitoToJson(x))):null,

  };
}

class Padre {
  Padre();

  factory Padre.fromJson(Map<String, dynamic> json) => Padre(
  );

  Map<String, dynamic> toJson() => {
  };
}

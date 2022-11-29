import 'dart:convert';




Utente utenteFromJson(String str) => Utente.fromJson(json.decode(str));

String utenteToJson(Utente data) => json.encode(data.toJson());

class Utente {
  Utente({
    this.id,
    required this.username,
    required this.password,
    required this.admin,
    this.idEnte,
    this.nomeEnte,
  });

  String? id;
  String username;
  String password;
  bool admin;
  String? idEnte;
  String? nomeEnte;


  factory Utente.fromJson(Map<String, dynamic> json) => Utente(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    admin: json["admin"],
    idEnte: json["idEnte"],
    nomeEnte: json["nomeEnte"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "admin": admin,
    "idEnte": idEnte,
    "nomeEnte": nomeEnte,
  };
}

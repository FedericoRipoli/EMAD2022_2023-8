// To parse this JSON data, do
//
//     final signupDto = signupDtoFromJson(jsonString);

import 'dart:convert';

SignupDto signupDtoFromJson(String str) => SignupDto.fromJson(json.decode(str));

String signupDtoToJson(SignupDto data) => json.encode(data.toJson());

class SignupDto {
  SignupDto({
    required this.username,
    required this.password,
    this.idEnte,
  });

  String username;
  String password;
  String? idEnte;

  factory SignupDto.fromJson(Map<String, dynamic> json) => SignupDto(
    username: json["username"],
    password: json["password"],
    idEnte: json["idEnte"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "idEnte": idEnte,
  };
}

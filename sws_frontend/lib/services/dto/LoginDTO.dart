// To parse this JSON data, do
//
//     final loginDto = loginDtoFromJson(jsonString);

import 'dart:convert';

LoginDto loginDtoFromJson(String str) => LoginDto.fromJson(json.decode(str));

String loginDtoToJson(LoginDto data) => json.encode(data.toJson());

class LoginDto {

  LoginDto(
      this.username,
      this.password,
      );
  String? username;
  String? password;

  factory LoginDto.fromJson(Map<String, dynamic> json) => LoginDto(
    json["username"],
    json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}

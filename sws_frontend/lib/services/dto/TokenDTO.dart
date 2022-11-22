// To parse this JSON data, do
//
//     final tokenDto = tokenDtoFromJson(jsonString);

import 'dart:convert';

TokenDto tokenDtoFromJson(String str) => TokenDto.fromJson(json.decode(str));

String tokenDtoToJson(TokenDto data) => json.encode(data.toJson());

class TokenDto {
  TokenDto({
    this.userId,
    this.accessToken,
    this.refreshToken,
  });

  String? userId;
  String? accessToken;
  String? refreshToken;

  factory TokenDto.fromJson(Map<String, dynamic> json) => TokenDto(
    userId: json["userId"],
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}

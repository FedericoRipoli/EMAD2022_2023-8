// To parse this JSON data, do
//
//     final imageData = imageDataFromJson(jsonString);

import 'dart:convert';

ImageData imageDataFromJson(String str) => ImageData.fromJson(json.decode(str));

String imageDataToJson(ImageData data) => json.encode(data.toJson());

class ImageData {
  ImageData({
    required this.id,
    required this.imageData,
    required this.nome,
    required this.type,
  });

  String id;
  String imageData;
  String nome;
  String type;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    id: json["id"],
    imageData: json["imageData"],
    nome: json["nome"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageData": imageData,
    "nome": nome,
    "type": type,
  };
}

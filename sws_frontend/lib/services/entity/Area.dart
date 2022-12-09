// To parse this JSON data, do
//
//     final area = areaFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend_sws/util/ColorExtension.dart';

Area areaFromJson(String str) => Area.fromJson(json.decode(str));

String areaToJson(Area data) => json.encode(data.toJson());

class Area {
  Area({
    this.id,
    required this.nome,
    required this.icon,
    required this.color
  });

  String? id;
  String nome;
  String icon;
  String color;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"],
    nome: json["nome"],
    icon: json["icon"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "icon": icon,
    "color": color,
  };
  IconData getIconData(){
    return IconData(int.parse(icon),fontFamily: "MaterialIcons");
  }
  Color getColorData(){
    return ColorExtension.fromHex(color);
  }
}

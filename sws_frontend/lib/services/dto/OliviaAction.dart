// To parse this JSON data, do
//
//     final oliviaAction = oliviaActionFromJson(jsonString);

import 'dart:convert';

OliviaAction oliviaActionFromJson(String str) => OliviaAction.fromJson(json.decode(str));

String oliviaActionToJson(OliviaAction data) => json.encode(data.toJson());

class OliviaAction {
  OliviaAction({
    required this.type,
    required this.value,
  });

  String type;
  String value;

  factory OliviaAction.fromJson(Map<String, dynamic> json) => OliviaAction(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}

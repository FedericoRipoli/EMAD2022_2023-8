// To parse this JSON data, do
//
//     final oliviaReceiveMessage = oliviaReceiveMessageFromJson(jsonString);

import 'dart:convert';

import 'OliviaAction.dart';

OliviaReceiveMessage oliviaReceiveMessageFromJson(String str) => OliviaReceiveMessage.fromJson(json.decode(str));

String oliviaReceiveMessageToJson(OliviaReceiveMessage data) => json.encode(data.toJson());

class OliviaReceiveMessage {
  OliviaReceiveMessage({
    this.content,
    this.tag,
    this.action
  });
  OliviaAction? action;
  String? content;
  String? tag;

  factory OliviaReceiveMessage.fromJson(Map<String, dynamic> json) => OliviaReceiveMessage(
    content: json["content"],
    tag: json["tag"],
    action: json["action"]!=null ? OliviaAction.fromJson(json["action"]) :null
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "tag": tag,
    "action": action!=null? action!.toJson():null
  };
}


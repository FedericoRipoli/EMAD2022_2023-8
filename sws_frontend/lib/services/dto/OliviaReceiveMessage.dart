// To parse this JSON data, do
//
//     final oliviaReceiveMessage = oliviaReceiveMessageFromJson(jsonString);

import 'dart:convert';

OliviaReceiveMessage oliviaReceiveMessageFromJson(String str) => OliviaReceiveMessage.fromJson(json.decode(str));

String oliviaReceiveMessageToJson(OliviaReceiveMessage data) => json.encode(data.toJson());

class OliviaReceiveMessage {
  OliviaReceiveMessage({
    this.content,
    this.tag,
  });

  String? content;
  String? tag;

  factory OliviaReceiveMessage.fromJson(Map<String, dynamic> json) => OliviaReceiveMessage(
    content: json["content"],
    tag: json["tag"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "tag": tag,
  };
}


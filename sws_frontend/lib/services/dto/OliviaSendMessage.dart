// To parse this JSON data, do
//
//     final oliviaSendMessage = oliviaSendMessageFromJson(jsonString);

import 'dart:convert';

OliviaSendMessage oliviaSendMessageFromJson(String str) => OliviaSendMessage.fromJson(json.decode(str));

String oliviaSendMessageToJson(OliviaSendMessage data) => json.encode(data.toJson());

class OliviaSendMessage {
  OliviaSendMessage({

    required this.content,
  });

  int type=1;
  String locale="it";
  String content;

  factory OliviaSendMessage.fromJson(Map<String, dynamic> json) => OliviaSendMessage(

    content: json["content"]
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "locale": locale,
    "content": content,
  };
}

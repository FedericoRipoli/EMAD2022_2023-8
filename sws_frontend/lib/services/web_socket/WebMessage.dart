
class WebMessage {
  int type;
  String? content;
  String? token;
  String? tag;

  WebMessage({required this.type, this.content, this.token, this.tag});

  Map<String, dynamic> toJson() => {
    "type" : type,
    "content" : content,
    "token" : token
  };

  factory WebMessage.fromJson(Map<String, dynamic> json) => WebMessage(
      type: 1,
      content: json["content"],
      tag: json["tag"]
  );

  WebMessage handShake() => WebMessage(type: 0);
}
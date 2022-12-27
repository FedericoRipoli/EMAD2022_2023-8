import 'package:flutter/material.dart';
import 'package:frontend_sws/services/RestURL.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'dto/OliviaReceiveMessage.dart';
import 'dto/OliviaSendMessage.dart';

class ChatBotService {
  final log = Logger('AreeServiceLoger');
  late WebSocketChannel channel;
  final ValueChanged<OliviaReceiveMessage> valueChanged;

  ChatBotService(this.valueChanged){
    channel = WebSocketChannel.connect(RestURL.oliviaService);
    channel.stream.listen((event) {
      valueChanged(oliviaReceiveMessageFromJson(event));
    });
  }


  void send(OliviaSendMessage send){
    channel.sink.add(oliviaSendMessageToJson(send));
  }


  void close(){
    channel.sink.close();
  }


}
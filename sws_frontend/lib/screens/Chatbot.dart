import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("CHATBOT"),
    );
  }
}
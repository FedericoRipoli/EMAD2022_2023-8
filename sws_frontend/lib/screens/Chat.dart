import 'dart:convert';
import 'package:bubble/bubble.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:getwidget/getwidget.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../main.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool admin = false;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _loadMessages();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();

    //FINITO L'ASCOLTO MANDA IL MESSAGGIO NELLA CHAT
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: _lastWords,
    );
    if (textMessage.text.isNotEmpty && textMessage.text.length != 0 && textMessage.text != "")
      _addMessage(textMessage);
    _lastWords = "";
    print(_lastWords);

    //AGGIORNA LO STATO DELLA CHAT
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }


  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton:
    Container(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed:
        // If not yet listening for speech start, otherwise stop
        _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      )
    ),
    appBar: GFAppBar(
      leading: GFIconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        type: GFButtonType.transparent,
      ),
      searchBar: false,
      elevation: 0,
      backgroundColor: appTheme.primaryColor,
    ),
    body: Container(
      decoration: BoxDecoration(color: Color.fromARGB(255,29,28,33)),
      padding: EdgeInsets.only(bottom: 80),
      child: Chat(
        bubbleBuilder: _bubbleBuilder,
        messages: _messages,
        //onAttachmentPressed: _handleAttachmentPressed, //Upload images and files
        //onMessageTap: _handleMessageTap,
        //onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: _user,
      ),
    ),
  );
  Widget _bubbleBuilder(
      Widget child, {
        required message,
        required nextMessageInGroup,
      }) =>
      Bubble(
        child: child,
        radius: Radius.circular(40),
        nipHeight: 40,
        nipWidth: 5,
        color: _user.id != message.author.id ||
            message.type == types.MessageType.image
            ? const Color.fromARGB(255,125,125,125)
            : const Color.fromARGB(255,0,89,179),
        margin: nextMessageInGroup
            ? const BubbleEdges.symmetric(horizontal: 6)
            : null,
        nip: nextMessageInGroup
            ? BubbleNip.no
            : _user.id != message.author.id
            ? BubbleNip.leftBottom
            : BubbleNip.rightBottom,
      );
}
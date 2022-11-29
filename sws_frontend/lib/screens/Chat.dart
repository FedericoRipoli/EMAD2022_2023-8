import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bubble/bubble.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:uuid/uuid.dart';
import 'package:getwidget/getwidget.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../components/CustomFloatingButton.dart';
import '../main.dart';
import 'package:frontend_sws/util/TtsManager.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool admin = false;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TtsManager _ttsManager;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _loadMessages();
    _ttsManager = TtsManager();
    if (_messages.isEmpty) {
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Ciao sono Olivia 😀\nCome posso aiutarti?",
      ));
    }
  }

  @override
  void dispose() {
    _ttsManager.stop();
    _saveMessages();
    super.dispose();
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
    if (textMessage.text.isNotEmpty &&
        textMessage.text.length != 0 &&
        textMessage.text != "") _addMessage(textMessage);
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
  final _bot = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3aa',
    firstName: 'Olivia',
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

  void _saveMessages() async {
    final writer = jsonEncode(_messages);
    SharedPreferencesUtils.prefs
        .setString(SharedPreferencesUtils.chatLog, writer);
  }

  void _loadMessages() async {
    final response = SharedPreferencesUtils.prefs
            .getString(SharedPreferencesUtils.chatLog) ??
        '';
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
        AvatarGlow(
          glowColor: Colors.red,
          animate: _speechToText.isListening,
          endRadius: 70,
          child:CustomFloatingButton(
            iconData: _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            onPressed: _speechToText.isNotListening
                ? _startListening
                : _stopListening,
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
          title: Text("Olivia"),
          centerTitle: true,
          elevation: 1,
          backgroundColor: appTheme.primaryColor,
        ),
        body: Container(
          decoration: BoxDecoration(color: AppColors.ice),
          padding: EdgeInsets.only(bottom: 100),
          child: Chat(
            theme: const DefaultChatTheme(
                inputBackgroundColor: AppColors.ice,
                sendButtonIcon: Icon(
                  Icons.send,
                  color: AppColors.logoBlue,
                ),
                inputTextColor: AppColors.logoBlue,
                inputTextCursorColor: AppColors.logoBlue,
                userAvatarImageBackgroundColor: AppColors.grayPurple,
                userAvatarNameColors: [
                  AppColors.logoBlue,
                  AppColors.grayPurple
                ],
                secondaryColor: AppColors.grayPurple),
            bubbleBuilder: _bubbleBuilder,
            messages: _messages,
            l10n: const ChatL10nEn(
              inputPlaceholder: 'Digita...',
            ),
            textMessageOptions: const TextMessageOptions(
              isTextSelectable: false,
            ),
            onSendPressed: _handleSendPressed,
            onMessageDoubleTap: (context, message) => {
              _ttsManager.speak(message.toJson()['text']),
            },
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
            ? AppColors.ice
            : AppColors.logoBlue,
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

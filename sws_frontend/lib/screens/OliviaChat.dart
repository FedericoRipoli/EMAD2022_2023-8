import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chattypes;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:frontend_sws/components/loading/AllPageLoad.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';

import '../components/generali/CustomAppBar.dart';
import '../theme/theme.dart';
import '../util/TtsManager.dart';

class OliviaChat extends StatefulWidget {
  const OliviaChat({super.key});

  @override
  State<OliviaChat> createState() => _OliviaChatState();
}

class _OliviaChatState extends State<OliviaChat> {
  late TtsManager _ttsManager;
  final SpeechToText _speechToText = SpeechToText();
  final List<chattypes.Message> _messages = [];
  TextEditingController inputController = TextEditingController();
  final _user = const chattypes.User(id: 'current');
  bool loaded=false;
  final _bot = const chattypes.User(
    id: 'bot',
    firstName: 'Olivia',
  );
  bool isListen = false;

  void _initSpeech() async {
    await _speechToText.initialize();
    loaded=true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _ttsManager = TtsManager();
    _addMessage(chattypes.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Ciao sono Olivia 😀\nCome posso aiutarti?",
    ));
    _initSpeech();

  }

  void addBotTyping() {
    _addMessage(chattypes.CustomMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        type: chattypes.MessageType.custom,
        metadata: const {"typing": "true"}));
  }



  Widget _buildTyping(chattypes.CustomMessage message){
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserName(author: message.author),
            DefaultTextStyle(
                style: const TextStyle(
                  color: neutral0,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Sta scrivendo....'),
                  ],
                  repeatForever: true,
                  isRepeatingAnimation: true,
                ))
          ],
        ));
  }
  void removeTyping(){
    List<chattypes.CustomMessage> toDelete=_messages.whereType<chattypes.CustomMessage>().where((element) => element.metadata!=null).where((element) => element.metadata!.containsKey("typing")).toList();
    for (var element in toDelete) {_messages.remove(element);}

  }


  @override
  Widget build(BuildContext context) {
    return !loaded?const AllPageLoad():Scaffold(
      appBar: const CustomAppBar(title: AppTitle(label: "Olivia")),
      body: Chat(

          messages: _messages,
          customMessageBuilder: (message, {required messageWidth}) {
            if(message.metadata!=null){
              if(message.metadata!.containsKey("typing")){

                removeTyping();
                return _buildTyping(message);
              }
            }
            return const Text("ERRORE");

          },
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          onMessageTap: (context, message) async {
            if (message.type == chattypes.MessageType.text) {
              _ttsManager.speak(message.toJson()['text']);
            }
          },
          bubbleBuilder: _bubbleBuilder,
          onSendPressed: _handleSendPressed,
          customBottomWidget: Column(
            children: [
              Input(
                onSendPressed: _handleSendPressed,
                options: InputOptions(textEditingController: inputController),
              ),
              Container(
                  width: double.infinity,
                  color: AppColors.bgLightBlue,
                  child: Column(
                    children: [
                      AvatarGlow(
                        glowColor: AppColors.logoCadmiumOrange,
                        animate: isListen,
                        endRadius: 50,
                        child: FloatingActionButton(
                            onPressed: isListen ? stopListen : startListen,
                            child: Icon(
                              isListen ? Icons.mic_off : Icons.mic,
                              color: Colors.white,
                            )),
                      ),
                      const Text(
                        "Premi sul messaggio per ascoltarlo!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.logoCadmiumOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  )),
            ],
          ),
          l10n: const ChatL10nEn(
              inputPlaceholder: 'Digita...',
              emptyChatPlaceholder: 'Chat vuota',
              sendButtonAccessibilityLabel: 'Invia'),
          theme: const DefaultChatTheme(
            inputTextColor: AppColors.logoBlue,
            inputTextCursorColor: AppColors.logoBlue,
            inputBackgroundColor: AppColors.bgLightBlue,
            userAvatarImageBackgroundColor: AppColors.grayPurple,
            userAvatarNameColors: [AppColors.logoBlue, AppColors.grayPurple],
            secondaryColor: AppColors.grayPurple,
            sendButtonIcon: Icon(
              Icons.send,
              color: AppColors.logoBlue,
            ),
          )),
    );
  }

  @override
  void dispose() {
    _ttsManager.stop();
    super.dispose();
  }

  void startListen() async {
    isListen = true;
    await _speechToText.listen(
      partialResults: true,
      pauseFor: const Duration(minutes: 15),
      onResult: (result) {
        if (isListen) {
          inputController.text = result.recognizedWords;
        }
      },
    );
    setState(() {});
  }

  void stopListen() async {
    await _speechToText.stop();
    isListen = false;
    setState(() {});
  }

  void _handleSendPressed(chattypes.PartialText message) {
    _sendMessage(message.text, _user);

    stopListen();
    addBotTyping();
  }

  void _sendMessage(String message, chattypes.User sender) {
    final textMessage = chattypes.TextMessage(
      author: sender,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message,
    );

    _addMessage(textMessage);
    if (sender == _user) _chatBotResponse(message);
  }

  void _addMessage(chattypes.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _chatBotResponse(String text) {}

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) {
    return Bubble(
      radius: const Radius.circular(40),
      nipHeight: 40,
      nipWidth: 5,
      color: _user.id != message.author.id ||
              message.type == chattypes.MessageType.image
          ? AppColors.bgLightBlue
          : AppColors.logoBlue,
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(horizontal: 6)
          : null,
      nip: nextMessageInGroup
          ? BubbleNip.no
          : _user.id != message.author.id
              ? BubbleNip.leftBottom
              : BubbleNip.rightBottom,
      child: child,
    );
  }
}

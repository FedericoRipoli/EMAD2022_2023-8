import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chattypes;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:frontend_sws/components/loading/AllPageLoad.dart';
import 'package:frontend_sws/screens/servizi/ServiziScreen.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../components/generali/CustomAppBar.dart';
import '../services/ChatBotService.dart';
import '../services/dto/OliviaAction.dart';
import '../services/dto/OliviaReceiveMessage.dart';
import '../services/dto/OliviaSendMessage.dart';
import '../theme/theme.dart';
import '../util/ToastUtil.dart';
import '../util/TtsManager.dart';
import 'eventi/EventiScreen.dart';

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
  bool loaded = false;

  bool loadStt = false;
  bool loadWebSocket = true;
  bool loadTts = false;
  final _bot = const chattypes.User(
    id: 'bot',
    firstName: 'Olivia',
  );
  bool isListen = false;
  late ChatBotService chatBotService;

  void onMessageReceive(OliviaReceiveMessage message) {
    if (message.content != null) {
      _sendMessage(message.content!, _bot);

      if(message.action!=null){
        _sendActionMessage(message, _bot);

      }
    } else {
      _sendMessage("Errore", _bot);
    }
    removeTyping();
  }

  void onError(dynamic e) {
    removeTyping();

    loadWebSocket = false;
    setState(() {});
    ToastUtil.error("Errore di comunicazione con il server", context);
  }

  void _initSpeech() async {
    try {
      await _speechToText.initialize();
      loadStt = true;
    } on Exception catch (_, e) {

    }
    loaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    try {
      _ttsManager = TtsManager();
      loadTts = true;
    } on Exception catch (_, e) {}

    chatBotService = ChatBotService(onMessageReceive, onError);
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

  Widget _buildTyping(chattypes.CustomMessage message) {
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
  Widget _buildAction(chattypes.CustomMessage message) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserName(author: message.author),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: ()=>performAction(message.metadata!["action"]),
              child: const Text('Vai!'),
            ),
          ],
        ));
  }
  void performAction(String actionJson){
    OliviaAction oa=oliviaActionFromJson(actionJson);
    switch (oa.type){
      case "OPENSERVICE":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiziScreen()),
        );
        break;
      case "OPENEVENT":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventiScreen()),
        );
        break;
      default:break;
    }
  }

  void removeTyping() {
    List<chattypes.CustomMessage> toDelete = _messages
        .whereType<chattypes.CustomMessage>()
        .where((element) => element.metadata != null)
        .where((element) => element.metadata!.containsKey("typing"))
        .toList();
    for (var element in toDelete) {
      _messages.remove(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !loaded
        ? const AllPageLoad()
        : Scaffold(
            appBar: const CustomAppBar(title: AppTitle(label: "Olivia")),
            body: Chat(
                messages: _messages,
                customMessageBuilder: (message, {required messageWidth}) {
                  if (message.metadata != null) {
                    if (message.metadata!.containsKey("typing")) {
                      removeTyping();
                      return _buildTyping(message);
                    } else if(message.metadata!.containsKey("action")){
                      return _buildAction(message);
                    }
                  }
                  return const Text("ERRORE");
                },
                showUserAvatars: true,
                showUserNames: true,
                user: _user,
                onMessageTap: (context, message) async {
                  if (message.type == chattypes.MessageType.text && loadTts) {
                    _ttsManager.speak(message.toJson()['text']);
                  }
                },
                bubbleBuilder: _bubbleBuilder,
                onSendPressed: _handleSendPressed,
                customBottomWidget: Column(
                  children: [
                    Input(
                      onSendPressed: _handleSendPressed,
                      options:
                          InputOptions(textEditingController: inputController),
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
                                  backgroundColor:
                                      !loadStt ? AppColors.greyLight : null,
                                  onPressed: loadStt
                                      ? isListen
                                          ? stopListen
                                          : startListen
                                      : null,
                                  child: loadStt
                                      ? Icon(
                                          isListen ? Icons.mic_off : Icons.mic,
                                          color: Colors.white,
                                        )
                                      : const Icon(Icons.mic_off,
                                          color: AppColors.logoRed),
                                )),
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
                  userAvatarNameColors: [
                    AppColors.logoBlue,
                    AppColors.grayPurple
                  ],
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
    if (loadTts) {
      _ttsManager.stop();
    }
    if (loadWebSocket) {
      chatBotService.close();
    }
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
    if (loadWebSocket) {
      _sendMessage(message.text, _user);

      stopListen();
      addBotTyping();
      chatBotService.send(OliviaSendMessage(content: message.text));
    } else {
      ToastUtil.error("Errore di comunicazione con il server", context);
    }
  }

  void _sendMessage(String message, chattypes.User sender) {
    final textMessage = chattypes.TextMessage(
      author: sender,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message,
    );

    _addMessage(textMessage);
  }
  void _sendActionMessage(OliviaReceiveMessage message, chattypes.User sender) {
    _addMessage(chattypes.CustomMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        type: chattypes.MessageType.custom,
        metadata: {"action": oliviaActionToJson(message.action!)}));

  }

  void _addMessage(chattypes.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

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

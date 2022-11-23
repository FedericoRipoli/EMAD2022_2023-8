import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class TtsManager {
  late FlutterTts flutterTts;
  String? newVoiceText;
  int? inputLength;
  late TtsState state;

  TtsManager() {
    flutterTts = FlutterTts();
    state = TtsState.stopped;
    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
    flutterTts.setLanguage('it');
    flutterTts.setCompletionHandler(() {
      state = TtsState.stopped;
    });
    flutterTts.setCancelHandler(() {
      state = TtsState.stopped;
    });
    flutterTts.setStartHandler(() {
      state = TtsState.playing;
    });
    flutterTts.setErrorHandler((msg) {
      state = TtsState.stopped;
    });
  }

  Future _getDefaultEngine() async => await flutterTts.getDefaultEngine;

  Future _getDefaultVoice() async => await flutterTts.getDefaultVoice;

  get isPlaying => state == TtsState.playing;
  get isStopped => state == TtsState.stopped;
  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  void speak(String message) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setPitch(1.0);
    if (message.isNotEmpty) {
      await flutterTts.speak(message);
      state = TtsState.playing;
    }
  }

  void stop() async {
    var result = await flutterTts.stop();
    if (result == 1) state = TtsState.stopped;
  }
}

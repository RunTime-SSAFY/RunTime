import 'dart:async';
import 'dart:collection';

import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  FlutterTts flutterTts = FlutterTts();

  Queue<String> messageQ = Queue<String>();

  Timer? _timer;

  void addMessage(String message) {
    messageQ.add(message);
  }

  void startTts() async {
    await flutterTts.setLanguage('ko');
    await flutterTts.setPitch(0.75);
    await flutterTts.setSpeechRate(0.6);

    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        if (messageQ.isNotEmpty) {
          flutterTts.speak(messageQ.removeFirst());
        }
      },
    );
  }

  void speak() async {
    await flutterTts.speak(messageQ.removeFirst());
  }

  void endTts() {
    _timer?.cancel();
    messageQ.clear();
    flutterTts.stop();
  }
}

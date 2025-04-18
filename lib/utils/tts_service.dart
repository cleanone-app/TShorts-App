import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> initTTS() async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVoice({"name": "ko-kr-x-ism-local", "locale": "ko-KR"});
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  Future<void> saveToFile(String text, String filePath) async {
    await _flutterTts.setVoice({"name": "ko-kr-x-ism-local", "locale": "ko-KR"});
    await _flutterTts.synthesizeToFile(text, filePath);
  }
}

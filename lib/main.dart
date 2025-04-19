import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tshorts_app/video_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TShorts',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts _flutterTts = FlutterTts();
  double _speechRate = 0.5;
  String _inputText = "감성적인 하루, 그 속에 담긴 이야기";
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _flutterTts.setSpeechRate(_speechRate);
    _flutterTts.setVoice({"name": "ko-KR-Wavenet-A", "locale": "ko-KR"});
  }

  Future<void> _speak() async {
    if (_inputText.isEmpty) return;

    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/voice.mp3';

    setState(() => _isSpeaking = true);
    await _flutterTts.synthesizeToFile(_inputText, path);
    setState(() => _isSpeaking = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('음성 생성 완료!')),
    );
  }

  Future<void> _generateVideo() async {
    final dir = await getTemporaryDirectory();
    final imagePath = '${dir.path}/background1.jpg';
    final audioPath = '${dir.path}/voice.mp3';

    final imageAsset = await rootBundle.load('assets/images/background1.jpg');
    final musicAsset = await rootBundle.load('assets/music/bgm1.mp3');

    final imageFile = File(imagePath)..writeAsBytesSync(imageAsset.buffer.asUint8List());
    final audioTemp = File('${dir.path}/bgm1.mp3')..writeAsBytesSync(musicAsset.buffer.asUint8List());

    final mixedAudio = '${dir.path}/final_audio.mp3';

    // bgm + voice 합치기
    final mergeCommand = '-i "$audioPath" -i "${audioTemp.path" -filter_complex amix=inputs=2:duration=first:dropout_transition=2 "$mixedAudio"';
    await FFmpegKit.execute(mergeCommand);

    final videoPath = await VideoGenerator.generateVideo(
      imagePath: imageFile.path,
      audioPath: mixedAudio,
      outputFileName: 'tshorts_video.mp4',
    );

    await Share.shareXFiles([XFile(videoPath)], text: 'TShorts 감성 브이로그 영상!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TShorts 감성 브이로그')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '감성 문구 입력',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _inputText = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("말 빠르기"),
                Expanded(
                  child: Slider(
                    value: _speechRate,
                    min: 0.2,
                    max: 1.0,
                    onChanged: (value) {
                      setState(() => _speechRate = value);
                      _flutterTts.setSpeechRate(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isSpeaking ? null : _speak,
              icon: const Icon(Icons.record_voice_over),
              label: const Text('TTS 음성 생성'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _generateVideo,
              icon: const Icon(Icons.video_call),
              label: const Text('영상 생성 및 공유'),
            ),
          ],
        ),
      ),
    );
  }
}

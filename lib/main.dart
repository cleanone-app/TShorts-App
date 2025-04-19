import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const TShortsApp());
}

class TShortsApp extends StatelessWidget {
  const TShortsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TShorts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.notoSansKrTextTheme(),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
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
    if (_inputText.isNotEmpty) {
      setState(() => _isSpeaking = true);
      await _flutterTts.speak(_inputText);
      setState(() => _isSpeaking = false);
    }
  }

  Future<void> _pickTextFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      setState(() {
        _inputText = content;
      });
    }
  }

  Future<void> _shareText() async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/tshorts.txt');
    await file.writeAsString(_inputText);
    await Share.shareXFiles([XFile(file.path)], text: 'TShorts 자막 텍스트');
  }

  Future<void> _requestPermissions() async {
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    _requestPermissions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TShorts 텍스트 입력'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _pickTextFile,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareText,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                maxLines: null,
                controller: TextEditingController(text: _inputText),
                onChanged: (value) => _inputText = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '쇼츠에 사용할 텍스트를 입력하세요',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('말하기 속도'),
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
            ElevatedButton.icon(
              onPressed: _isSpeaking ? null : _speak,
              icon: const Icon(Icons.play_arrow),
              label: const Text('음성으로 듣기'),
            ),
          ],
        ),
      ),
    );
  }
}
